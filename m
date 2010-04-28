From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 4/4] OMAP3: PM: export chip IDCODE,
	Production ID and Die ID
Date: Wed, 28 Apr 2010 09:21:02 -0700
Message-ID: <87k4rrh7kh.fsf@deeprootsystems.com>
References: <1272433903-24003-1-git-send-email-eduardo.valentin@nokia.com>
	<1272433903-24003-5-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1272433903-24003-5-git-send-email-eduardo.valentin@nokia.com>
	(Eduardo Valentin's message of "Wed\,
	28 Apr 2010 08\:51\:43 +0300")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, "\\ De-Schrijver Peter \\\\ (Nokia-D/Helsinki)" <Peter.De-Schrijver@nokia.com>, santosh.shilimkar@ti.com, felipe.balbi@nokia.com, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Eduardo Valentin <eduardo.valentin@nokia.com> writes:

> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>
> This patch exports the OMAP3 IDCODE and Production ID to userspace
> via /proc/cpuinfo using the system_soc_info.
>
> Die ID is also exported depending on what users pass as kernel
> parameter. It is same protection mechanism made for x86 product
> number. So, if user passes "omap3_die_id" parameter, it will append
> die id code into /proc/cpuinfo as well. A Kconfig option has been
> added as well, so it can be configurable during compilation time.
>
> This can be used to track down silicon specific issues. The info is
> exported via /proc/cpuinfo because then it can be possible to include this
> in corematic dumps.
>
> This is based on Peter De Schrijver patch, which export same info via sysfs.
>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>

Re: $SUBJECT, why the PM: prefix?

Kevin
