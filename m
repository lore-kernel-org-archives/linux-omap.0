From: Bryan Wu <bryan.wu@canonical.com>
Subject: Re: [PATCH 3/3] OMAP: use generic panel driver in board files
Date: Wed, 3 Nov 2010 11:42:59 -0400
Message-ID: <AANLkTinmgo+=qJ3WJSep52YhfihDQkD5hUsz=uyrtbox@mail.gmail.com>
References: <1288730392-11223-1-git-send-email-bryan.wu@canonical.com>
	<1288730392-11223-4-git-send-email-bryan.wu@canonical.com>
	<FCCFB4CDC6E5564B9182F639FC356087034BE1EB1A@dbde02.ent.ti.com>
	<1288796931.5614.199.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1288796931.5614.199.camel@tubuntu>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "ext Taneja,
	Archit" <archit@ti.com>, "notasas@gmail.com" <notasas@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Gadiyar, Anand" <gadiyar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 3, 2010 at 11:08 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Wed, 2010-11-03 at 13:56 +0100, ext Taneja, Archit wrote:
>> Hi,
>>
>> linux-omap-owner@vger.kernel.org wrote:
>> > Introduce some fields in struct panel, which will be used to
>> > match the right panel configurations in generic panel driver.
>> >
>> > Still keep sharp_ls_panel, since the sharp_ls_panel driver
>> > contains blacklight control driver code which will be moved
>> > out later. Then we can use generic driver for sharp_ls_panel.
>> >
>> > Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
>>
>> [snip]
>>
>> > diff --git a/arch/arm/plat-omap/include/plat/display.h
>> > b/arch/arm/plat-omap/include/plat/display.h
>> > index c915a66..6e1fbbd 100644
>> > --- a/arch/arm/plat-omap/include/plat/display.h
>> > +++ b/arch/arm/plat-omap/include/plat/display.h
>> > @@ -346,6 +346,24 @@ struct omap_overlay_manager {
>> > =A0 =A0 int (*disable)(struct omap_overlay_manager *mgr); =A0};
>> >
>> > +struct omap_display_panel {
>> > + =A0 struct omap_video_timings timings;
>> > +
>> > + =A0 int acbi; =A0 =A0 =A0 /* ac-bias pin transitions per interrupt *=
/ + =A0 /* Unit: line
>> > clocks */ + int acb; =A0 =A0 =A0 =A0/* ac-bias pin frequency */
>> > +
>> > + =A0 enum omap_panel_config config;
>> > +
>> > + =A0 int power_on_delay;
>> > + =A0 int power_off_delay;
>> > + =A0 /*
>> > + =A0 =A0* Used to match device to panel configuration
>> > + =A0 =A0* when use generic panel driver
>> > + =A0 =A0*/
>> > + =A0 const char *name;
>> > +};
>> > +
>> > =A0struct omap_dss_device {
>> > =A0 =A0 struct device dev;
>> >
>> > @@ -395,15 +413,7 @@ struct omap_dss_device {
>> > =A0 =A0 =A0 =A0 =A0 =A0 } venc;
>> > =A0 =A0 } phy;
>> >
>> > - =A0 struct {
>> > - =A0 =A0 =A0 =A0 =A0 struct omap_video_timings timings;
>> > -
>> > - =A0 =A0 =A0 =A0 =A0 int acbi; =A0 =A0 =A0 /* ac-bias pin transitions=
 per
>> > interrupt */
>> > - =A0 =A0 =A0 =A0 =A0 /* Unit: line clocks */
>> > - =A0 =A0 =A0 =A0 =A0 int acb; =A0 =A0 =A0 =A0/* ac-bias pin frequency=
 */
>> > -
>> > - =A0 =A0 =A0 =A0 =A0 enum omap_panel_config config;
>> > - =A0 } panel;
>> > + =A0 struct omap_display_panel panel;
>> >
>> > =A0 =A0 struct {
>> > =A0 =A0 =A0 =A0 =A0 =A0 u8 pixel_size;
>>
>> I don't think that changing the omap_dss_device structure is the best way
>> to go about this. Members like power_on_delay and power_off_delay may not
>> be required by all types of panels. Same goes for the new "name" member =
since
>> its only used by the dummy dpi panels.
>>
>> I think it would be better to go with the approach taken in panel-taal.c
>> where a struct "panel_config" exists to take care of extra requirements.
>>
>> The omap_dss_device struct should contain only those members which would=
 be
>> needed by the interface driver files like dsi.c, dpi.c etc. The rest sho=
uld be
>> taken care of the panel drivers internally.
>
> Yes, the configuration for the panel is panel driver specific features,
> and should not be in the standard structs. No need to add anything to
> display.h.
>
> In fact, there are things in display.h that should be removed, and this
> configurable panel driver could do that also. omap_dss_device contains
> reset_gpio, max_backlight_level, platform_enable/disable and
> set/get_backlight, which should actually be in panel spesific struct.
>

After a quick study of panel-taal.c driver and board-4430sdp.c, I
believe we can pass the information from *data pointer of struct
omap_dss_device. And keep the all panel specific configuration in
driver.

I will keep the struct omap_dss_device untouched.

Thanks,
-Bryan
