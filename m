From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: Some modification to GPMC library - Can we ?
Date: Tue, 14 Nov 2006 13:00:30 -0600
Message-ID: <77C7F7CB1230A74A9D19C0C111E6EDBE01DFABDD@DLEE09.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
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

Hi Juha,

I was looking at GPMC library arch/arm/mach-omap2/gpmc.c. I was thinking
if we could export gpmc_cs_set_reserved and gpmc_cs_reserved APIs. So
that, other libraries and drivers can access these APIs with out doing a
gpmc_request.=20

The reason is, if I have already configured a GPMC CS in boot loader I
might not be interested in doing the same again in Kernel. However I
might want to reserve this particular CS so that it doesn't show as free
when others do a gpmc_request.=20

I might be looking at one of the scenarios. Please do let me know if you
find any issues with the same.

Regards,
Khasim
=20
