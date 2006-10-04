From: Marcin Juszkiewicz <openembedded@hrw.one.pl>
Subject: Re: Disable DSPGW fails
Date: Wed, 4 Oct 2006 12:11:52 +0200
Message-ID: <200610041211.53114.openembedded@hrw.one.pl>
References: <4523752A.8020601@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_pj4IFjbdNyrGldH"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <4523752A.8020601@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_pj4IFjbdNyrGldH
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Dnia =B6roda, 4 pa=BCdziernika 2006 10:47, Dirk Behme napisa=B3:

> while debugging the OSK issue, I tried to disable DSPGW
> completely (CONFIG_OMAP_DSP is not set). On most recent git
> this fails with
>
> arch/arm/plat-omap/built-in.o: In function `omap_mcbsp_free':
> mcbsp.c:(.text+0x44b8): undefined reference to
> `omap_dsp_release_mem'
> arch/arm/plat-omap/built-in.o: In function `omap_mcbsp_request':
> mcbsp.c:(.text+0x45cc): undefined reference to
> `omap_dsp_request_mem'
>
> Anybody with an idea how to fix this?

Attached patch fix it. Feel free to push it into correct maintainer to get=
=20
it included in GIT tree.

=2D-=20
JID: hrw-jabber.org
OpenEmbedded developer

             Today is the first day of the rest of your life.

--Boundary-00=_pj4IFjbdNyrGldH
Content-Type: text/x-diff; charset="iso-8859-1";
	name="linux-omap-no-dsp-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="linux-omap-no-dsp-fix.patch"


while debugging the OSK issue, I tried to disable DSPGW 
completely (CONFIG_OMAP_DSP is not set). 

On most recent git this fails with

arch/arm/plat-omap/built-in.o: In function `omap_mcbsp_free':
mcbsp.c:(.text+0x44b8): undefined reference to 
`omap_dsp_release_mem'
arch/arm/plat-omap/built-in.o: In function `omap_mcbsp_request':
mcbsp.c:(.text+0x45cc): undefined reference to 
`omap_dsp_request_mem'

This patch fixes it.

Signed-off-by: Marcin Juszkiewicz <openembedded@hrw.one.pl>


Index: git/arch/arm/plat-omap/mcbsp.c
===================================================================
--- git.orig/arch/arm/plat-omap/mcbsp.c 2006-09-27 12:17:21.000000000 +0200
+++ git/arch/arm/plat-omap/mcbsp.c      2006-09-27 12:17:01.000000000 +0200
@@ -197,7 +197,9 @@
 static void omap_mcbsp_dsp_request(void)
 {
        if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
+#ifdef CONFIG_OMAP_DSP
                omap_dsp_request_mem();
+#endif
                clk_enable(mcbsp_dsp_ck);
                clk_enable(mcbsp_api_ck);

@@ -216,7 +218,9 @@
 static void omap_mcbsp_dsp_free(void)
 {
        if (cpu_is_omap15xx() || cpu_is_omap16xx()) {
+#ifdef CONFIG_OMAP_DSP
                omap_dsp_release_mem();
+#endif
                clk_disable(mcbsp_dspxor_ck);
                clk_disable(mcbsp_dsp_ck);
                clk_disable(mcbsp_api_ck);

--Boundary-00=_pj4IFjbdNyrGldH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_pj4IFjbdNyrGldH--
