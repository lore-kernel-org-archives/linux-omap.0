From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 3/3] pm changes for am335x and am437x for v5.2
Date: Sun, 28 Apr 2019 23:04:24 -0700
Message-ID: <20190429060424.vw2giqpcnkcwkqm2@localhost>
References: <pull-1555087688-487222@atomide.com>
 <pull-1555087688-487222@atomide.com-3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1555087688-487222@atomide.com-3>
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

On Fri, Apr 12, 2019 at 10:02:07AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.2/am4-pm-v2-signed
> 
> for you to fetch changes up to 35667d812c38a219ea2dc6f23d33db50de57099e:
> 
>   Merge branch 'omap-for-v5.2/am4-ddr3' into omap-for-v5.2/am4-pm-v2 (2019-04-10 09:06:01 -0700)
> 
> ----------------------------------------------------------------
> PM changes for am335x and am437x
> 
> This series adds support for am437x RTC-only mode in suspend. In the
> RTC-only mode suspend, everything is shut down except the RTC. This
> makes the power consumption very low for suspend mode.
> 
> To support RTC-only mode, we need to export omap_rtc_power_off_program()
> from the rtc driver and improve PM code to save and restore the wkup
> domain context. As RTC-only mode depends on the device being wired
> properly for things like memory, we need to also check for the machine
> type before we allow it. We also need to run DDR3 hardware leveling on
> resume.
> 
> Note that there is a trivial merge conflict between the RTC branch
> and these changes where the RTC branch makes tm2bcd() a void function
> and the error handling parts can be just dropped.

Merged, thanks!


-Olof
