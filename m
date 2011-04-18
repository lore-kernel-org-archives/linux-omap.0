From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/14] Remove sysdev suspend/resume and shutdown operations
Date: Sun, 17 Apr 2011 23:02:18 -0700
Message-ID: <20110418060218.GB22168@suse.de>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
Content-Disposition: inline
In-Reply-To: <201104172301.54115.rjw@sisk.pl>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Russell King <linux@arm.linux.org.uk>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>, Kay Sievers <kay.sievers@suse.de>, Mike Frysinger <vapier@gentoo.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Sun, Apr 17, 2011 at 11:01:53PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> The following series of patches fixes bugs related to the introduction
> of struct syscore_ops later in this cycle, replaces sysdev suspend/resume
> operations in all of the architectures still using them with struct
> syscore_ops-based PM callbacks and finally removes the suspend/resume
> and shutdown operations from struct sysdev_class and struct sysdev_driver.
> 
> Patches [1/14] and [2/14] are important bug fixes targeted at 2.6.39.
> The remaining patches are regareded as 2.6.40 material, but I'd like to
> put them into linux-next shortly, if there are no objections, to catch
> problems that they may introduce before they hit the mainline.  Again,
> if there are no objections I'd like to merge these patches through the
> suspend-2.6 tree.

No objection from me at all, thanks for doing this they look great.

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
