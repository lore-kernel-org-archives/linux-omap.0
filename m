From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: DISPC: Update Fir Coefficients
Date: Fri, 16 Dec 2011 10:26:17 +0530
Message-ID: <CAF0AtAtaCGpgeYxss0H_jbYWOwJJ_LW0W8-eqM20juKTAGassA@mail.gmail.com>
References: <1323838310-4439-1-git-send-email-cmahapatra@ti.com>
	<1323939331.2010.27.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:39320 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756346Ab1LPE4S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 23:56:18 -0500
In-Reply-To: <1323939331.2010.27.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org

On Thu, Dec 15, 2011 at 2:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Wed, 2011-12-14 at 10:21 +0530, Chandrabhanu Mahapatra wrote:
>
>> +const struct dispc_coef *dispc_ovl_get_scale_coef(int inc, int five=
_taps)
>> +{
>> + =A0 =A0 int i;
>> + =A0 =A0 static const struct {
>> + =A0 =A0 =A0 =A0 =A0 =A0 int Mmin;
>> + =A0 =A0 =A0 =A0 =A0 =A0 int Mmax;
>> + =A0 =A0 =A0 =A0 =A0 =A0 const struct dispc_coef *coef_3;
>> + =A0 =A0 =A0 =A0 =A0 =A0 const struct dispc_coef *coef_5;
>> + =A0 =A0 } coefs[] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 26, 32, coef3_M32, coef5_M32 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 22, 26, coef3_M26, coef5_M26 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 19, 22, coef3_M22, coef5_M22 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 16, 19, coef3_M19, coef5_M19 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 14, 16, coef3_M16, coef5_M16 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 13, 14, coef3_M14, coef5_M14 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 12, 13, coef3_M13, coef5_M13 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 11, 12, coef3_M12, coef5_M12 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { 10, 11, coef3_M11, coef5_M11 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { =A09, 10, coef3_M10, coef5_M10 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { =A08, =A09, =A0coef3_M9, =A0coef5_M9 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { =A03, =A08, =A0coef3_M8, =A0coef5_M8 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* When upscaling more than two times, b=
lockiness and outlines
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* around the image are observed when M8=
 tables are used. M11,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* M16 and M19 tables are used to preven=
t this.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 { =A02, =A03, coef3_M11, coef5_M11 },
>> + =A0 =A0 =A0 =A0 =A0 =A0 { =A01, =A02, coef3_M16, coef5_M16 },
>> + =A0 =A0 };
>> +
>> + =A0 =A0 inc /=3D 128;
>> + =A0 =A0 for (i =3D 0; i < ARRAY_LEN(coefs); ++i)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (inc > coefs[i].Mmin && inc <=3D coefs[=
i].Mmax)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return five_taps ? coefs[i=
].coef_5 : coefs[i].coef_3;
>> + =A0 =A0 if (inc =3D=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return five_taps ? coef3_M19 : coef5_M19;
>> + =A0 =A0 return NULL;
>> +}
>
> Why don't you handle the inc =3D=3D 1 case the same as others? Just h=
ave an
> entry in the table for Mmin=3D0, Mmax =3D 1.
>
=46or inc=3D1 i.e. M=3D1 , scaling ratio is maximum as L/M=3D8. DISPC s=
caler
doesnot support upscaling more than 8 itmes. Having an (Mmin,Mmax] of
(0,1] will allow such cases.
> Also, I think it's a bit confusing that Mmin is exclusive and Mmax is
> inclusive in the comparison. It makes the table a bit hard to read, w=
hen
> looking at which entry is used for which inc. I'd recommend using
> inclusive comparison for both.
>
> =A0Tomi
>
Having both inclusive will allow us to delete the extra comparison for
inc=3D=3D1 but in my opinion having Mmin exclusive and Mmax inclusive
actually gives an clear idea of comparison. The tables mostly go by
the Mmax value.
=46or example, for inc=3D26 coef3/5_M26 table is selected, for inc=3D22
coef3/5_M22 is selected etc.
If we have both Mmin and Mmax as inclusive above case becomes slightly
incoherent. Say for M=3D26 instead of coef3/5_M26 which seems more
obvious choice coef3/5_M32 is selected.

=46or both inclusive cases to work and avoid confusion and delete extra
comparison for inc=3D=3D1 , I have to reverse the order of table entrie=
s
in "coef" table. But for that I will have to put the "When upscaling
more than two times, blockiness and outlines" comment at the beginning
of the table and then start with  {  1,  2, coef3_M16, coef5_M16 }.
This will create even more confusion.


--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
