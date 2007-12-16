From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] Remove omap_sram_idle()
Date: Sun, 16 Dec 2007 08:44:59 -0600
Message-ID: <3B6D69C3A9EBCA4BA5DA60D91302742902CC143D@dlee13.ent.ti.com>
References: <11977918242059-git-send-email-vivek.kutal@celunite.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
In-Reply-To: <11977918242059-git-send-email-vivek.kutal@celunite.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Vivek Kutal <vivek.kutal@celunite.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> 	This patch removes omap_sram_idle().

Why?

> Signed-off-by: Vivek Kutal <vivek.kutal@celunite.com>

Execution in SRAM on some OMAPs is needed and in others it provides a =
more likely path to hitting deep sleep states.  There is sensitivity of =
running in SDRAM when trying to shut this down.

On 1509 there was not alternative as sleeping when the SDR was not in =
self-refresh was impossible.  On 1510 an automated self-refresh was =
added based on an internal signal.

I've not tried an OMAP1 in a while so I'm not sure what issues there =
might be today.  There are tree's which do hit big and deep sleep and I =
think they still use something close to this.

Regards,
Richard W.
