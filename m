From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] omap fixes against v4.4-rc2
Date: Wed, 25 Nov 2015 23:49:28 +0100
Message-ID: <15820949.xv0lSuANaf@wuerfel>
References: <20151125223704.GV2517@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151125223704.GV2517@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, arm@kernel.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 25 November 2015 14:37:04 Tony Lindgren wrote:
> Fixes for omaps for v4.4-rc cycle:
> 
> - A series of audio changes for dra7 that missed the merge window but turned
>   out to be necessary to fix a boot time imprecise external abort error and to
>   getaudio working
> 
> - Fix l4 related boot time errors for dm81xx
> 
> - Use lockless cldm/pwrdm api in omap4_boot_secondary
> 
> - Remove t410 custom abort handler that is no longer needed and may
>   hide other critical errors
> 
> - Mark cpuidle tracepoints as _rcuidle
> 
> - Fix module alias for omap-ocp2scp
> 

Merged into fixes, thanks!

	Arnd
