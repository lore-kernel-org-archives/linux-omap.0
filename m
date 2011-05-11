From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH RESEND] omap : nand : fix subpage ecc issue with prefetch
Date: Wed, 11 May 2011 19:45:39 +0530
Message-ID: <BANLkTi=OenjvSObPg8=ynwhCH8CEyUeMqA@mail.gmail.com>
References: <1304950899-26009-1-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1304950899-26009-1-git-send-email-kishore.kadiyala@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Vimal Singh <vimal.newwork@gmail.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, dedekind1@gmail.com
List-Id: linux-omap@vger.kernel.org

Oops forgot to CC stable@kernel.org, posting again without any changes.

Regards,
Kishore

On Mon, May 9, 2011 at 7:51 PM, Kishore Kadiyala
<kishore.kadiyala@ti.com> wrote:
> When reading/writing a subpage (When HW ECC is not available/enabled)
> for number of bytes not aligned to 4, the mis-aligned bytes are handled
> first (by cpu copy method) before enabling the Prefetch engine to/from
> 'p'(start of buffer 'buf'). Then it reads/writes rest of the bytes with
> the help of Prefetch engine, if available, or again using cpu copy method.
> Currently, reading/writing of rest of bytes, is not done correctly since
> its trying to read/write again to/from begining of buffer 'buf',
> overwriting the mis-aligned bytes.
>
> Read & write using prefetch engine got broken in commit '2c01946c'.
> We never hit a scenario of not getting 'gpmc_prefetch_enable' call
> success. So, problem did not get caught up.
>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Vimal Singh <vimal.newwork@gmail.com>
> Reported-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
> ---
> =A0drivers/mtd/nand/omap2.c | =A0 12 +++++-------
> =A01 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index da9a351..2c8040f 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -263,11 +263,10 @@ static void omap_read_buf_pref(struct mtd_info *mtd=
, u_char *buf, int len)
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* PFPW engine is busy, use cpu copy metho=
d */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (info->nand.options & NAND_BUSWIDTH_16)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf16(mtd, buf, l=
en);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf16(mtd, (u_cha=
r *)p, len);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf8(mtd, buf, le=
n);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_read_buf8(mtd, (u_char=
 *)p, len);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D (u32 *) buf;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r_count =3D gpmc_read_stat=
us(GPMC_PREFETCH_FIFO_CNT);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0r_count =3D r_count >> 2;
> @@ -293,7 +292,7 @@ static void omap_write_buf_pref(struct mtd_info *mtd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0struct omap_nand_info, mtd);
> =A0 =A0 =A0 =A0uint32_t w_count =3D 0;
> =A0 =A0 =A0 =A0int i =3D 0, ret =3D 0;
> - =A0 =A0 =A0 u16 *p;
> + =A0 =A0 =A0 u16 *p =3D (u16 *)buf;
> =A0 =A0 =A0 =A0unsigned long tim, limit;
>
> =A0 =A0 =A0 =A0/* take care of subpage writes */
> @@ -309,11 +308,10 @@ static void omap_write_buf_pref(struct mtd_info *mt=
d,
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* PFPW engine is busy, use cpu copy metho=
d */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (info->nand.options & NAND_BUSWIDTH_16)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write_buf16(mtd, buf, =
len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write_buf16(mtd, (u_ch=
ar *)p, len);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write_buf8(mtd, buf, l=
en);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_write_buf8(mtd, (u_cha=
r *)p, len);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 p =3D (u16 *) buf;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while (len) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w_count =3D gpmc_read_stat=
us(GPMC_PREFETCH_FIFO_CNT);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0w_count =3D w_count >> 1;
> --
> 1.7.4.1
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
>

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
