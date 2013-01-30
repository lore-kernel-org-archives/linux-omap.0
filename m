From: "Kumar, Anil" <anilkumar.v-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] arm: dts: omap4-sdp: Add I2c pinctrl data
Date: Wed, 30 Jan 2013 08:43:46 +0000
Message-ID: <F3DBB1B3EF102E4994C89758CFCA32412C16DD@DBDE01.ent.ti.com>
References: <1359371865-27907-1-git-send-email-sourav.poddar@ti.com>
 <1359527158.14894.37.camel@cumari.coelho.fi> <5108C052.3070604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5108C052.3070604-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Poddar, Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, "Coelho, Luciano" <coelho-l0cyMroinI0@public.gmane.org>
Cc: "Vishwanathrao Badarkhe, Manish" <manishv.b-l0cyMroinI0@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi,
 Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "Shilimkar, Santosh" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Sourav,

On Wed, Jan 30, 2013 at 12:10:18, Poddar, Sourav wrote:
> Hi Luciano,
> On Wednesday 30 January 2013 11:55 AM, Luciano Coelho wrote:
> > Hi Sourav,
> >
> > On Mon, 2013-01-28 at 16:47 +0530, Sourav Poddar wrote:
> >> Booting 3.8-rc4 om omap 4430sdp results in the following error
> >>
> >> omap_i2c 48070000.i2c: did not get pins for i2c error: -19
> >> [    1.024261] omap_i2c 48070000.i2c: bus 0 rev0.12 at 100 kHz
> >> [    1.030181] omap_i2c 48072000.i2c: did not get pins for i2c error: -19
> >> [    1.037384] omap_i2c 48072000.i2c: bus 1 rev0.12 at 400 kHz
> >> [    1.043762] omap_i2c 48060000.i2c: did not get pins for i2c error: -19
> >> [    1.050964] omap_i2c 48060000.i2c: bus 2 rev0.12 at 100 kHz
> >> [    1.056823] omap_i2c 4807a000.i2c: did not get pins for i2c error: -19
> >> [    1.064025] omap_i2c 4807a000.i2c: bus 3 rev0.12 at 400 kHz
> >>
> >> This happens because omap4 dts file is not adapted to use i2c through pinctrl
> >> framework. Populating i2c pinctrl data to get rid of the error.
> >>
> >> Tested on omap4430 sdp with 3.8-rc4 kernel.
> >>
> >> Signed-off-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> >> Reported-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
> >> ---
> > Could you do the same thing for panda? I'm getting the same kind of
> > errors with it:

omap4 uses pinctrl-single driver for pinmux with DT. Currently
pinctrl-single driver is getting up after I2C driver. So I2c cannot
use pinctrl. The below patch solve this issue     

http://www.gossamer-threads.com/lists/linux/kernel/1669067

Can you try with this ? it may solve it.

Thanks,
Anil
[...]
