From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] mfd: twl-core: export twl_get_regmap
Date: Mon, 21 Nov 2016 09:31:45 +0000
Message-ID: <20161121093144.GE23750@n2100.armlinux.org.uk>
References: <1478950693-13959-1-git-send-email-Nicolae_Rosia@mentor.com>
 <20161118185548.GA23246@dell.home>
 <CAKP5S=3quz8f1H0xnaffJ35L8qSOpSkBEGS8GsNhB5F=v3DoBg@mail.gmail.com>
 <20161121092339.GA32509@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20161121092339.GA32509@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Nicolae Rosia <nicolae.rosia.oss@gmail.com>, linux-omap@vger.kernel.org, Nicolae Rosia <Nicolae_Rosia@mentor.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 21, 2016 at 09:23:39AM +0000, Lee Jones wrote:
> It's common place to pass shared resources such as 'regmap' though
> device data.  You can find many examples of *__set_drvdata throughout
> the kernel.

Passing data between drivers using *_set_drvdata() is a layering
violation:

1. Driver data is supposed to be driver private data associated with
   the currently bound driver.
2. The driver data pointer is NULL'd when the driver unbinds from the
   device.  See __device_release_driver() and the
   dev_set_drvdata(dev, NULL).
3. It will break with CONFIG_DEBUG_TEST_DRIVER_REMOVE enabled for a
   similar reason to (2).

So, do not pass data between drivers using *_set_drvdata() - any
examples in the kernel already are founded on bad practice, are
fragile, and are already broken for some kernel configurations.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
