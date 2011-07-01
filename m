From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [RFC 07/12] omap: mcbsp: Get rid of remaining is_omap tests
Date: Fri, 1 Jul 2011 16:41:23 +0530
Message-ID: <CA+HSevrUgP8pKNjSgkpDB6hUX=cvCUOU8mpU2Ca5qa75Rnp36w@mail.gmail.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com> <1309510356-27147-8-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:37838 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753132Ab1GALMG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 07:12:06 -0400
Received: by mail-qy0-f172.google.com with SMTP id 9so578834qyk.3
        for <linux-omap@vger.kernel.org>; Fri, 01 Jul 2011 04:12:04 -0700 (PDT)
In-Reply-To: <1309510356-27147-8-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Peter Ujfalusi <peter.ujfalusi@ti.com>

Jarkko,

On Fri, Jul 1, 2011 at 14:22, Jarkko Nikula <jhnikula@gmail.com> wrote:
> We can get rid of remaining is_omap tests in the driver by using
> mcbsp_config_type that is set in omap hwmod data for 2430, 34xx and 4=
4xx.
>
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> =A0arch/arm/plat-omap/mcbsp.c | =A0 30 ++++++++++++++----------------
> =A01 files changed, 14 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> index 92d6d4f..47720b1 100644
> --- a/arch/arm/plat-omap/mcbsp.c
> +++ b/arch/arm/plat-omap/mcbsp.c
> @@ -193,7 +193,7 @@ void omap_mcbsp_config(unsigned int id, const str=
uct omap_mcbsp_reg_cfg *config)
> =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, MCR2, config->mcr2);
> =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, MCR1, config->mcr1);
> =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, PCR0, config->pcr0);
> - =A0 =A0 =A0 if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_om=
ap44xx()) {
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type >=3D MCBSP_CONFIG_TYPE2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, XCCR, config->xccr)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, RCCR, config->rccr)=
;
> =A0 =A0 =A0 =A0}
> @@ -531,14 +531,13 @@ void omap_mcbsp_set_tx_threshold(unsigned int i=
d, u16 threshold)
> =A0{
> =A0 =A0 =A0 =A0struct omap_mcbsp *mcbsp;
>
> - =A0 =A0 =A0 if (!cpu_is_omap34xx() && !cpu_is_omap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> =A0 =A0 =A0 =A0if (!omap_mcbsp_check_valid_id(id)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: Invalid id (%d)\n=
", __func__, id + 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mcbsp =3D id_to_mcbsp_ptr(id);
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type < MCBSP_CONFIG_TYPE3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> =A0 =A0 =A0 =A0if (threshold && threshold <=3D mcbsp->max_tx_thres)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, THRSH2, threshold -=
 1);
> @@ -554,14 +553,13 @@ void omap_mcbsp_set_rx_threshold(unsigned int i=
d, u16 threshold)
> =A0{
> =A0 =A0 =A0 =A0struct omap_mcbsp *mcbsp;
>
> - =A0 =A0 =A0 if (!cpu_is_omap34xx() && !cpu_is_omap44xx())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> =A0 =A0 =A0 =A0if (!omap_mcbsp_check_valid_id(id)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: Invalid id (%d)\n=
", __func__, id + 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mcbsp =3D id_to_mcbsp_ptr(id);
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type < MCBSP_CONFIG_TYPE3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> =A0 =A0 =A0 =A0if (threshold && threshold <=3D mcbsp->max_rx_thres)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, THRSH1, threshold -=
 1);
> @@ -698,7 +696,7 @@ static inline void omap34xx_mcbsp_request(struct =
omap_mcbsp *mcbsp)
> =A0 =A0 =A0 =A0 * Enable wakup behavior, smart idle and all wakeups
> =A0 =A0 =A0 =A0 * REVISIT: some wakeups may be unnecessary
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type >=3D MCBSP_CONFIG_TYPE3) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, WAKEUPEN, XRDYEN | =
RRDYEN);
> =A0 =A0 =A0 =A0}
> =A0}
> @@ -712,7 +710,7 @@ static inline void omap34xx_mcbsp_free(struct oma=
p_mcbsp *mcbsp)
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Disable wakup behavior, smart idle and all wakeups
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type >=3D MCBSP_CONFIG_TYPE3) {


I think that it would be a good idea to not use
MCBSP_CONFIG_TYPE* in plat-omap/* as it is the .rev info.
At later point of time, this might make the code look uglier
as it happened with GPIO_METHOD_* flags in OMAP GPIO driver.
Instead use this .rev info in mach-omap*/ to fill the pdata and pass it
to driver.

-V Charulatha

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * HW bug workaround - If no_idle mode=
 is taken, we need to
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * go to smart_idle before going to al=
ways_idle, or the
> @@ -872,7 +870,7 @@ void omap_mcbsp_start(unsigned int id, int tx, in=
t rx)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mcbsp =3D id_to_mcbsp_ptr(id);
>
> - =A0 =A0 =A0 if (cpu_is_omap34xx())
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type =3D=3D MCBSP_CONFIG_TYPE3)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_st_start(mcbsp);
>
> =A0 =A0 =A0 =A0/* Only enable SRG, if McBSP is master */
> @@ -910,7 +908,7 @@ void omap_mcbsp_start(unsigned int id, int tx, in=
t rx)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, SPCR2, w | (1 << 7)=
);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_om=
ap44xx()) {
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type >=3D MCBSP_CONFIG_TYPE2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Release the transmitter and receive=
r */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w =3D MCBSP_READ_CACHE(mcbsp, XCCR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w &=3D ~(tx ? XDISABLE : 0);
> @@ -940,7 +938,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int=
 rx)
>
> =A0 =A0 =A0 =A0/* Reset transmitter */
> =A0 =A0 =A0 =A0tx &=3D 1;
> - =A0 =A0 =A0 if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_om=
ap44xx()) {
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type >=3D MCBSP_CONFIG_TYPE2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w =3D MCBSP_READ_CACHE(mcbsp, XCCR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w |=3D (tx ? XDISABLE : 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, XCCR, w);
> @@ -950,7 +948,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int=
 rx)
>
> =A0 =A0 =A0 =A0/* Reset receiver */
> =A0 =A0 =A0 =A0rx &=3D 1;
> - =A0 =A0 =A0 if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_om=
ap44xx()) {
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type >=3D MCBSP_CONFIG_TYPE2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w =3D MCBSP_READ_CACHE(mcbsp, RCCR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w |=3D (rx ? RDISABLE : 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, RCCR, w);
> @@ -967,7 +965,7 @@ void omap_mcbsp_stop(unsigned int id, int tx, int=
 rx)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MCBSP_WRITE(mcbsp, SPCR2, w & ~(1 << 6=
));
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (cpu_is_omap34xx())
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type =3D=3D MCBSP_CONFIG_TYPE3)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_st_stop(mcbsp);
> =A0}
> =A0EXPORT_SYMBOL(omap_mcbsp_stop);
> @@ -1230,7 +1228,7 @@ static void __devexit omap_st_remove(struct oma=
p_mcbsp *mcbsp)
> =A0static inline void __devinit omap34xx_device_init(struct omap_mcbs=
p *mcbsp)
> =A0{
> =A0 =A0 =A0 =A0mcbsp->dma_op_mode =3D MCBSP_DMA_MODE_ELEMENT;
> - =A0 =A0 =A0 if (cpu_is_omap34xx()) {
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type =3D=3D MCBSP_CONFIG_TYPE3)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Initially configure the maximum thr=
esholds to a safe value.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * The McBSP FIFO usage with these val=
ues should not go under
> @@ -1262,7 +1260,7 @@ static inline void __devinit omap34xx_device_in=
it(struct omap_mcbsp *mcbsp)
>
> =A0static inline void __devexit omap34xx_device_exit(struct omap_mcbs=
p *mcbsp)
> =A0{
> - =A0 =A0 =A0 if (cpu_is_omap34xx()) {
> + =A0 =A0 =A0 if (mcbsp->mcbsp_config_type =3D=3D MCBSP_CONFIG_TYPE3)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_additional_remove(mcbsp->dev);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mcbsp->id =3D=3D 2 || mcbsp->id =3D=
=3D 3)
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
