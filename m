From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL 1/2] omap defconfig changes for v4.15 merge window
Date: Thu, 2 Nov 2017 16:48:14 +0100
Message-ID: <CAK8P3a26fgpZ1BympPxC+cJX6nUm+PYfbDPTEh_onvgf0=UTMw@mail.gmail.com>
References: <pull-1509381562-551838@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <pull-1509381562-551838@atomide.com>
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
Cc: linux-omap <linux-omap@vger.kernel.org>, arm-soc <arm@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> ----------------------------------------------------------------
> Few omap2plus_defconfig changes for v4.15 merge window to enable NEON
> based crypto and droid 4 USB PHY. Also let's run savedefconfig again
> to save a bit of space and make it easier for people to send patches
> against omap2plus_defconfig.

I'm not too fond of the blind 'rerun savedefconfig' patches. Can you respin that
branch and separate that one into at least two patches doing:

- one trivial patch to move the config options that have not changed but only
  appear in a different line

- one patch that drops the other options and has an explanation for each one
  why it's not there any more. Split this up further if necessary.

I mainly want to be sure when we do this that we have not accidentally
dropped an option that got renamed but is actually required for some users.

      Arnd
