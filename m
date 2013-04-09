From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 3/5] omap board changes for v3.10 merge window
Date: Tue, 9 Apr 2013 14:36:41 +0200
Message-ID: <201304091436.42046.arnd@arndb.de>
References: <0Lgo4c-1UueHv2nOo-00naI8@mx.kundenserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0Lgo4c-1UueHv2nOo-00naI8@mx.kundenserver.de>
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
Cc: Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 09 April 2013, Tony Lindgren wrote:
> The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:
> 
>   Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/board-signed
> 
> for you to fetch changes up to 06993d6a8a51b90fc78c8c3cb7a81c9b4b88c683:
> 
>   ARM: OMAP: board-4430sdp: Provide regulator to pwm-backlight (2013-04-08 14:01:05 -0700)
> 
> ----------------------------------------------------------------
> Board related changes for v3.10 merge window. These are pretty
> much all non-critical fixes for platform device initialization
> that will be needed until we can drop the board-*.c files and
> move to DT based boot.
> 

Pulled into next/boards branch

	Arnd
