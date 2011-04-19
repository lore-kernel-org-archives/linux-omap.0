From: "Guan Xuetao" <gxt@mprc.pku.edu.cn>
Subject: RE: [PATCH 12/14] PM / UNICORE32: Use struct syscore_ops instead of sysdevs for PM
Date: Tue, 19 Apr 2011 16:02:55 +0800
Message-ID: <006201cbfe68$3ad01380$b0703a80$@mprc.pku.edu.cn>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl> <201104172313.45854.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201104172313.45854.rjw@sisk.pl>
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>, 'LKML' <linux-kernel@vger.kernel.org>
Cc: 'Greg KH' <gregkh@suse.de>, 'Kay Sievers' <kay.sievers@suse.de>, 'Linux PM mailing list' <linux-pm@lists.linux-foundation.org>, 'Russell King' <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, 'Kevin Hilman' <khilman@ti.com>, linux-arm-kernel@lists.infradead.org, 'Ben Dooks' <ben-linux@fluff.org>, 'Mike Frysinger' <vapier@gentoo.org>, 'Ralf Baechle' <ralf@linux-mips.org>, 'Hans-Christian Egtvedt' <hans-christian.egtvedt@atmel.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, 'Jiri Kosina' <jkosina@suse.cz>, 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>, 'Jeremy Fitzhardinge' <jeremy.fitzhardinge@citrix.com>
List-Id: linux-omap@vger.kernel.org



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> Sent: Monday, April 18, 2011 5:14 AM
> To: LKML
> Cc: Greg KH; Kay Sievers; Linux PM mailing list; Russell King; linux-omap@vger.kernel.org; Kevin Hilman; linux-arm-
> kernel@lists.infradead.org; Ben Dooks; Mike Frysinger; Ralf Baechle; Hans-Christian Egtvedt; Guan Xuetao; Benjamin Herrenschmidt;
> linuxppc-dev@lists.ozlabs.org; Jiri Kosina; Konrad Rzeszutek Wilk; Jeremy Fitzhardinge
> Subject: [PATCH 12/14] PM / UNICORE32: Use struct syscore_ops instead of sysdevs for PM
> 
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Make some UNICORE32 architecture's code use struct syscore_ops
> objects for power management instead of sysdev classes and sysdevs.
> 
> This simplifies the code and reduces the kernel's memory footprint.
> It also is necessary for removing sysdevs from the kernel entirely in
> the future.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
