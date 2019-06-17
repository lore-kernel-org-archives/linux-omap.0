From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL 1/4] soc changes for omap variants for v5.3
Date: Mon, 17 Jun 2019 05:17:25 -0700
Message-ID: <20190617121725.tcyrjpoillqh6n6f@localhost>
References: <pull-1560399818-512977@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <pull-1560399818-512977@atomide.com>
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

On Thu, Jun 13, 2019 at 12:10:50AM -0700, Tony Lindgren wrote:
> From: "Tony Lindgren" <tony@atomide.com>
> 
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:
> 
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v5.3/soc-signed
> 
> for you to fetch changes up to 45450f36e569e5162957df488b0174c9a952e1b0:
> 
>   soc: ti: pm33xx: Add a print while entering RTC only mode with DDR in self-refresh (2019-06-10 05:19:26 -0700)
> 
> ----------------------------------------------------------------
> ti-sysc soc changes for v5.3
> 
> Just two changes to make few platform data functions static, and to
> call dev_info() if am437x is suspending to RTC-only mode. We want to
> see this in case of issues as it depends on the board wiring for things
> like DDR memory.

Merged, thanks!


-Olof
