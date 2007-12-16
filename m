From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: RE: [PATCH] Remove omap_sram_idle()
Date: Sun, 16 Dec 2007 17:11:41 +0200
Message-ID: <1197817901.14417.11.camel@mort>
References: <11977918242059-git-send-email-vivek.kutal@celunite.com>
	<3B6D69C3A9EBCA4BA5DA60D91302742902CC143D@dlee13.ent.ti.com>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D91302742902CC143D@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "ext Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


On Sun, 2007-12-16 at 08:44 -0600, ext Woodruff, Richard wrote:
> > 	This patch removes omap_sram_idle().
> 
> Why?
> 
> > Signed-off-by: Vivek Kutal <vivek.kutal@celunite.com>
> 
> Execution in SRAM on some OMAPs is needed and in others it provides a more likely path to hitting deep sleep states.  There is sensitivity of running in SDRAM when trying to shut this down.
> 
> On 1509 there was not alternative as sleeping when the SDR was not in self-refresh was impossible.  On 1510 an automated self-refresh was added based on an internal signal.
> 
> I've not tried an OMAP1 in a while so I'm not sure what issues there might be today.  There are tree's which do hit big and deep sleep and I think they still use something close to this.

Yup. Nokia 770 is one of them.
Or was, at least, I have to admit that I haven't checked an OMAP1 kernel
for a long time. But it used to work.

Vivek: did you make any measurement on your patch? It would be good if
you could share your findings.

-- 
Cheers, Igor

Igor Stoppa <igor.stoppa@nokia.com>
(Nokia Multimedia - CP - OSSO / Helsinki, Finland)
