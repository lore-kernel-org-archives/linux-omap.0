From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: problems compiling latest git update
Date: Tue, 18 Sep 2007 10:18:53 -0400
Message-ID: <a0580c510709180718p220404d0jc5eac7b15eeab93a@mail.gmail.com>
References: <ae36f8040709180700u671ae5fpc8fa4a0a7c8474c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <ae36f8040709180700u671ae5fpc8fa4a0a7c8474c0@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: lvcargnini@gmail.com
Cc: OMAP <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

On 9/18/07, Lu=EDs Cargnini <lvcargnini@gmail.com> wrote:
> Hi I uopgraded the source tree to latest creating a new kernel version fo=
r
> my device (latest), but i found two things, one is the following error:
> arch/arm/plat-omap/devices.c: In function 'omap_init_mmc':
> arch/arm/plat-omap/devices.c:348: error: 'OMAP2_CTRL_BASE' undeclared (fi=
rst
> use in this function)
> arch/arm/plat-omap/devices.c:348: error: (Each undeclared identifier is
> reported only once
> arch/arm/plat-omap/devices.c:348: error: for each function it appears in.=
)
>
> other is, where are the DSP config options ?

System Type  --->TI OMAP Implementations  --->

<*> OMAP DSP driver (DSP Gateway)
[ ]   Mailbox Command Verbose LOG (NEW)
[ ]   Framebuffer export to DSP (NEW)

CONFIG_OMAP_DSP, CONFIG_OMAP_DSP_MBCMD_VERBOSE, CONFIG_OMAP_DSP_FBEXPORT

Probably you may want to enable also CONFIG_OMAP_MMU_FWK and
CONFIG_OMAP_MBOX_FWK, which are automatically enable by selecting
CONFIG_OMAP_DSP from the menuconfig.

>
>
> --
> -------------------------------------------------------------------------=
-----
> Thanks && Regards
> Msc. Bsc. Lu=EDs Vit=F3rio Cargnini
> IEEE Member
> Electrical Engineer Faculty @ PUCRS
> Ipiranga Avenue, 6681 =96 Building 30
> P.O. Box: 90619-900 =96 Porto Alegre/RS
> Phone: +55 51 3320 3500  extension: 7696
> -------------------------------------------------------------------------=
--------
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>


--=20
Eduardo Bezerra Valentin
