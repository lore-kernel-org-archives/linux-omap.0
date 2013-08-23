From: Richard Zhao <rizhao@nvidia.com>
Subject: Re: [PATCH v2] DMA: add help function to check whether dma
 controller registered
Date: Fri, 23 Aug 2013 09:17:38 +0800
Message-ID: <20130823011738.GA17925@rizhao-lap>
References: <1375423458-6868-1-git-send-email-rizhao@nvidia.com>
 <1377153781-18006-1-git-send-email-rizhao@nvidia.com>
 <52167665.90602@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52167665.90602@wwwdotorg.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "vinod.koul@intel.com" <vinod.koul@intel.com>, "djbw@fb.com" <djbw@fb.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 23, 2013 at 04:36:53AM +0800, Stephen Warren wrote:
> On 08/22/2013 12:43 AM, Richard Zhao wrote:
> > DMA client device driver usually needs to know at probe time whether
> > dma controller has been registered to deffer probe. So add a help
> > function of_dma_check_controller.
> > 
> > DMA request channel functions can also used to check it, but they
> > are usually called at open() time.
> 
> This new function is almost identical to the existing
> of_dma_request_slave_channel(). Surely the code should be shared?
ofdma->of_dma_xlate(&dma_spec, ofdma);
The above is called holding of_dma_lock. If I want to abstract the
common lines, there' two options.

Option 1:
static struct of_dma* of_dma_check_controller_locked(np, name)
{
	parameter check
	get dma-names count and check return value
	for loop to get of_dma
	return PTR_ERR(err) or of_dma
}

struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
					      const char *name)
{
	chan = null;
	mutex_lock(&of_dma_lock);
	of_dma = of_dma_check_controller_locked(np, name)
	if(!IS_ERR(of_dma))
		chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
	mutex_unlock(&of_dma_lock);
	return chan;
}

int of_dma_check_controller(struct device *dev, const char *name)
{
	mutex_lock(&of_dma_lock);
	ofdma = of_dma_check_controller_locked(dev->of_node, name);
	mutex_unlock(&of_dma_lock);
	if (IS_ERR(ofdma))
		return ERR_PTR(ofdma);
	else
		return 0;
}

Option 2:
static struct of_dma* of_dma_check_controller_getlock(np, name)
{
	parameter check
	get dma-names count and check return value
	for loop to get of_dma, get lock at old place
	if failed, unlock.
	return PTR_ERR(err) or of_dma
}

struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
					      const char *name)
{
}	of_dma = of_dma_check_controller_getlock(np, name)
	if(!IS_ERR(of_dma)) {
		chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
		unlock;
	}
	return chan;
}

int of_dma_check_controller(struct device *dev, const char *name)
	ofdma = of_dma_check_controller_locked(dev->of_node, name);

	if (IS_ERR(ofdma)) {
		return ERR_PTR(ofdma);
	} else {
		unlock;
		return 0;
	}
}

> But that said, I don't see any need for a new function; why can't
> drivers simply call of_dma_request_slave_channel() at probe time;
It'll mislead user. channel supposed to be request at open time.

> from
> what I can see, that function doesn't actually request the channel, but
> rather simply looks it up, just like this one. The only difference is
> that of_dma_xlate() is also called, but that's just doing some data
> transformation, not actually recording channel ownership.
xlate function request the channel if things go well.

Thanks
Richard
