From: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: DISPC: Update Fir Coefficients
Date: Fri, 16 Dec 2011 14:06:44 +0530
Message-ID: <CAF0AtAtpBH8G8fQpJzci4dxwE=uiPyd-zTYse0R=-hLdPo1nFg@mail.gmail.com>
References: <1323838310-4439-1-git-send-email-cmahapatra@ti.com>
	<1323939331.2010.27.camel@deskari>
	<CAF0AtAtaCGpgeYxss0H_jbYWOwJJ_LW0W8-eqM20juKTAGassA@mail.gmail.com>
	<1324023305.1859.9.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:56966 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760164Ab1LPIgp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 03:36:45 -0500
In-Reply-To: <1324023305.1859.9.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap <linux-omap@vger.kernel.org>

On Fri, Dec 16, 2011 at 1:45 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2011-12-16 at 10:26 +0530, Mahapatra, Chandrabhanu wrote:
>> On Thu, Dec 15, 2011 at 2:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>> > On Wed, 2011-12-14 at 10:21 +0530, Chandrabhanu Mahapatra wrote:
>> >
>> >> +const struct dispc_coef *dispc_ovl_get_scale_coef(int inc, int f=
ive_taps)
>> >> +{
>> >> + =A0 =A0 int i;
>> >> + =A0 =A0 static const struct {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 int Mmin;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 int Mmax;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 const struct dispc_coef *coef_3;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 const struct dispc_coef *coef_5;
>> >> + =A0 =A0 } coefs[] =3D {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { 26, 32, coef3_M32, coef5_M32 },
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { 22, 26, coef3_M26, coef5_M26 },
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { 19, 22, coef3_M22, coef5_M22 },
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { 16, 19, coef3_M19, coef5_M19 },
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { 14, 16, coef3_M16, coef5_M16 },
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { 13, 14, coef3_M14, coef5_M14 },
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { 12, 13, coef3_M13, coef5_M13 },
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { 11, 12, coef3_M12, coef5_M12 },
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { 10, 11, coef3_M11, coef5_M11 },
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { =A09, 10, coef3_M10, coef5_M10 },
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { =A08, =A09, =A0coef3_M9, =A0coef5_M9 =
},
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { =A03, =A08, =A0coef3_M8, =A0coef5_M8 =
},
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* When upscaling more than two times=
, blockiness and outlines
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* around the image are observed when=
 M8 tables are used. M11,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* M16 and M19 tables are used to pre=
vent this.
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { =A02, =A03, coef3_M11, coef5_M11 },
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 { =A01, =A02, coef3_M16, coef5_M16 },
>> >> + =A0 =A0 };
>> >> +
>> >> + =A0 =A0 inc /=3D 128;
>> >> + =A0 =A0 for (i =3D 0; i < ARRAY_LEN(coefs); ++i)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (inc > coefs[i].Mmin && inc <=3D coe=
fs[i].Mmax)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return five_taps ? coef=
s[i].coef_5 : coefs[i].coef_3;
>> >> + =A0 =A0 if (inc =3D=3D 1)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return five_taps ? coef3_M19 : coef5_M1=
9;
>> >> + =A0 =A0 return NULL;
>> >> +}
>> >
>> > Why don't you handle the inc =3D=3D 1 case the same as others? Jus=
t have an
>> > entry in the table for Mmin=3D0, Mmax =3D 1.
>> >
>> For inc=3D1 i.e. M=3D1 , scaling ratio is maximum as L/M=3D8. DISPC =
scaler
>> doesnot support upscaling more than 8 itmes. Having an (Mmin,Mmax] o=
f
>> (0,1] will allow such cases.
>
> I don't think I understand. A table entry for 0,1 would match exactly
> one inc value, which is 1. Which is the same as you do with the separ=
ate
> if statement now.
>
yes, you are right.
>> > Also, I think it's a bit confusing that Mmin is exclusive and Mmax=
 is
>> > inclusive in the comparison. It makes the table a bit hard to read=
, when
>> > looking at which entry is used for which inc. I'd recommend using
>> > inclusive comparison for both.
>> >
>> > =A0Tomi
>> >
>> Having both inclusive will allow us to delete the extra comparison f=
or
>> inc=3D=3D1 but in my opinion having Mmin exclusive and Mmax inclusiv=
e
>> actually gives an clear idea of comparison. The tables mostly go by
>> the Mmax value.
>> For example, for inc=3D26 coef3/5_M26 table is selected, for inc=3D2=
2
>> coef3/5_M22 is selected etc.
>> If we have both Mmin and Mmax as inclusive above case becomes slight=
ly
>> incoherent. Say for M=3D26 instead of coef3/5_M26 which seems more
>> obvious choice coef3/5_M32 is selected.
>
> I don't understand this either... If you now have:
>
> { 26, 32, coef3_M32, coef5_M32 },
> { 22, 26, coef3_M26, coef5_M26 },
>
> It would be changed to
>
> { 27, 32, coef3_M32, coef5_M32 },
> { 23, 26, coef3_M26, coef5_M26 },
>
> and it would match the same inc values as before after changing the M=
min
> comparison to >=3D.
>
yes, I had mistakenly overlooked it.
>> For both inclusive cases to work and avoid confusion and delete extr=
a
>> comparison for inc=3D=3D1 , I have to reverse the order of table ent=
ries
>> in "coef" table. But for that I will have to put the "When upscaling
>> more than two times, blockiness and outlines" comment at the beginni=
ng
>> of the table and then start with =A0{ =A01, =A02, coef3_M16, coef5_M=
16 }.
>> This will create even more confusion.
>
> The ranges for the table elements are exclusive. The order doesn't
> matter because one inc value can only match one table entry. So I hav=
e
> to say I don't understand this comment either =3D). Am I missing
> something?
>
> =A0Tomi
>
I mistakenly thought inc to be float which created all this confusion.


--=20
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
