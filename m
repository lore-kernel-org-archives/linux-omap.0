From: "=?ISO-8859-1?Q?Lu=EDs_Cargnini?=" <lvcargnini@gmail.com>
Subject: Re: problems compiling latest git update
Date: Tue, 18 Sep 2007 13:14:54 -0300
Message-ID: <ae36f8040709180914q54881d2ex90c9ab9ceb0ab967@mail.gmail.com>
References: <ae36f8040709180700u671ae5fpc8fa4a0a7c8474c0@mail.gmail.com>
	<a0580c510709180718p220404d0jc5eac7b15eeab93a@mail.gmail.com>
Reply-To: lvcargnini@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <a0580c510709180718p220404d0jc5eac7b15eeab93a@mail.gmail.com>
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
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

I'm doing and mrproper doing from the beginning all the process I cloned
the git  to make my modifications and test over the  latest tree, and
redoing everything again to see what happen

On 9/18/07, Eduardo Valentin <edubezval@gmail.com> wrote:

>
> System Type  --->TI OMAP Implementations  --->
>
> <*> OMAP DSP driver (DSP Gateway)
> [ ]   Mailbox Command Verbose LOG (NEW)
> [ ]   Framebuffer export to DSP (NEW)
>
> CONFIG_OMAP_DSP, CONFIG_OMAP_DSP_MBCMD_VERBOSE, CONFIG_OMAP_DSP_FBEXPORT
>
> Probably you may want to enable also CONFIG_OMAP_MMU_FWK and
> CONFIG_OMAP_MBOX_FWK, which are automatically enable by selecting
> CONFIG_OMAP_DSP from the menuconfig.
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
