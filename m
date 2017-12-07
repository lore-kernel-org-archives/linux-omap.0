From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpdma: rate is not changed -
 correct case
Date: Thu, 7 Dec 2017 22:21:41 +0200
Message-ID: <20171207202140.GD3022@khorivan>
References: <20171207194855.GA3022@khorivan>
 <20171207.145024.1434883857028947517.davem@davemloft.net>
 <20171207201005.GC3022@khorivan>
 <20171207.151315.1535972470633975595.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171207.151315.1535972470633975595.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 07, 2017 at 03:13:15PM -0500, David Miller wrote:
> From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> Date: Thu, 7 Dec 2017 22:10:06 +0200
> 
> > On Thu, Dec 07, 2017 at 02:50:24PM -0500, David Miller wrote:
> >> From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> >> Date: Thu, 7 Dec 2017 21:48:56 +0200
> >> 
> >> > On Wed, Dec 06, 2017 at 04:35:45PM -0500, David Miller wrote:
> >> >> From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> >> >> Date: Wed,  6 Dec 2017 16:41:18 +0200
> >> >> 
> >> >> > If rate is the same as set it's correct case.
> >> >> > 
> >> >> > Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> >> >> > ---
> >> >> > Based on net-next/master
> >> >> > 
> >> >> >  drivers/net/ethernet/ti/davinci_cpdma.c | 2 +-
> >> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >> > 
> >> >> > diff --git a/drivers/net/ethernet/ti/davinci_cpdma.c b/drivers/net/ethernet/ti/davinci_cpdma.c
> >> >> > index e4d6edf..dbe9167 100644
> >> >> > --- a/drivers/net/ethernet/ti/davinci_cpdma.c
> >> >> > +++ b/drivers/net/ethernet/ti/davinci_cpdma.c
> >> >> > @@ -841,7 +841,7 @@ int cpdma_chan_set_rate(struct cpdma_chan *ch, u32 rate)
> >> >> >  		return -EINVAL;
> >> >> >  
> >> >> >  	if (ch->rate == rate)
> >> >> > -		return rate;
> >> >> > +		return 0;
> >> >> 
> >> >> Looking at the one and only caller of this function, cpsw_ndo_set_tx_maxrate, it
> >> >> makes sure this can never, ever, happen.
> >> > In current circumstances yes, it will never happen.
> >> > But I caught it while adding related code and better return 0 if upper caller
> >> > doesn't have such check. Suppose that cpdma module is responsible for itself
> >> > and if it's critical I can send this patch along with whole related series.
> >> 
> >> You have to decide one way or the other, who is responsible.
> >> 
> >> I think checking higher up is better because it's cheaper at that point to
> >> look at the per-netdev queue rate setting before moving down deeper into the
> >> driver specific data-structures.
> > 
> > No objection, but upper caller not always knows current rate and for doing like
> > this it needs read it first, and this is also some redundancy.
> 
> How can the upper caller not know the current rate?  The rate is
> always stored in the generic netdev per-queue datastructure.
> 
> And that's what existing code checks right now.
Right now, when generic netdev only caller - yes.

-- 
Regards,
Ivan Khoronzhuk
