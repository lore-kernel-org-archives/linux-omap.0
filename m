From: toshihiro.kobayashi@nokia.com
Subject: Re: Problems building DSP gateway on 2.6.15
Date: Thu, 23 Mar 2006 00:57:40 +0900 (JST)
Message-ID: <20060323.005740.730554090.toshihiro.kobayashi@nokia.com>
References: <20060320180002.1755A8062C@linux.omap.com>
	<001001c64cc8$d911a420$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <001001c64cc8$d911a420$642aa8c0@BUFFY>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: richard.copeman@lauterbach.co.uk, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: Problems building DSP gateway on 2.6.15
Date: Tue, 21 Mar 2006 09:21:34 -0000

> Warning: none of /sys/devicesplatform/dsp.0/ifver,
> /sys/devices/platform/dsp0..
> 
> (DSP Gateway driver is too old or not loaded)
> 
> open control device: No such file or directory.

> In /sys/devices/platform I have: i2c_omap.1, omap_mcbsp.1, omapflash.0,
> serial8250.0, omap-keyboard, omap_t2, power, smc91x, omap_cf, omapfb,
> serial8250 and uevent.

There should be /sys/devices/platform/dsp directory if the DSP Gateway is
compiled in the kernel. 
Do you see "OMAP DSP driver initialization" in the boot message?
If yes, DSP Gateway is in your kernel and I suspect you have a problem
in your fs. Otherwise your kernel doesn't contain DSP Gateway.
Didn't you miss to do 'make uImage'? (Since sometimes I do. :))

BR,
Toshihiro Kobayashi
