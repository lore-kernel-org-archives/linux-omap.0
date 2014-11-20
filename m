From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/2] omap non-urgent fixes for v3.19
Date: Thu, 20 Nov 2014 10:46:44 +0100
Message-ID: <201411201046.44262.arnd@arndb.de>
References: <pull-1415725783-562282>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1415725783-562282>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 11 November 2014, Tony Lindgren wrote:
> ----------------------------------------------------------------
> Fixes for omap3 that are not urgent. Mostly to remove unnecessary
> noise during the boot with pointless errors and warnings.
> 


Pulled into next/fixes-non-critical. We didn't have any other patches in there,
so I started out with -rc3 to avoid the back-merge problem. Any reason why
you didn't base this on -rc1 like the other branches?

	Arnd
