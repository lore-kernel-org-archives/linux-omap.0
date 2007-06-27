From: "=?ISO-8859-1?Q?Lu=EDs_Vit=F3rio_Cargnini?=" <lvcargnini@ieee.org>
Subject: Re: McBSP doubts and trying to find Samuel Ortiz
Date: Wed, 27 Jun 2007 17:42:41 -0300
Message-ID: <ae36f8040706271342h4e77e66xc5c7a6a0b004e686@mail.gmail.com>
References: <ae36f8040706261234s1378472w1129ce1814d53fb3@mail.gmail.com>
	<9C23CDD79DA20A479D4615857B2E2C47081101@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47081101@dlee13.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

thank you

On 6/27/07, Syed Mohammed, Khasim <x0khasim@ti.com> wrote:
>
>  You should be able to use McBSP driver to configure McBSP interfaces.
>
> Each McBSP interface can talk to multiple pheripherals on TDM basis and
> there are multiple McBSP interfaces - the comment you refered is related =
to
> this. So you are safe to use this driver to configure one McBSP interface=
 to
> talk to one peripheral (ADS8343).
>
> Regards,
> Khasim
>
> ------------------------------
> *From:* linux-omap-open-source-bounces+x0khasim=3Dti.com@linux.omap.com o=
n
> behalf of Lu=EDs Vit=F3rio Cargnini
> *Sent:* Tue 6/26/2007 2:34 PM
> *To:* OMAP
> *Subject:* McBSP doubts and trying to find Samuel Ortiz
>
>  Please if someone could help or repass this message to Samuel Ortiz
> thanks
>
>
> Dears and  Samuel Ortiz,
> I'm reading the source linux/arch/arm/plat-omap/mcbsp.c to see what kind
> of
> source I already have implemented of McBSP and i founded your source code=
,
> but I read the head comment and saw "Multichannel mode not supported". So
> can I use your functions to access the McBSP interfaces from my own devic=
e
> driver or this is not possible ?
> I'm writing an device driver for ADS8343, to communicate throw McBSP of
> OMAP
> 5912 in ARM side.
>
>
> --
>
> -------------------------------------------------------------------------=
-----
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Electrical Engineer Faculty @ PUCRS
> Ipiranga Avenue, 6681 =96 Building 30
> P.O. Box: 90619-900 =96 Porto Alegre/RS
> Phone: +55 51 3320 3500  extension: 7696
>
> -------------------------------------------------------------------------=
--------
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>


--=20
---------------------------------------------------------------------------=
---
Thanks && Regards
Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
IEEE Member
Electrical Engineer Faculty @ PUCRS
Ipiranga Avenue, 6681 =96 Building 30
P.O. Box: 90619-900 =96 Porto Alegre/RS
Phone: +55 51 3320 3500  extension: 7696
---------------------------------------------------------------------------=
------
