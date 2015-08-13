From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] omap gpmc null pointer fix against v4.2-rc6
Date: Thu, 13 Aug 2015 14:27:55 +0200
Message-ID: <20150813122755.GB23581@localhost>
References: <20150813082022.GL10928@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20150813082022.GL10928@atomide.com>
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

On Thu, Aug 13, 2015 at 01:20:22AM -0700, Tony Lindgren wrote:
> The following changes since commit cd4556733b30cc363adc7b1cea3bffa7e2dd0c7c:
> 
>   ARM: dts: dra7: Fix broken pbias device creation (2015-08-05 03:04:07 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/fixes-rc6
> 
> for you to fetch changes up to e984a1791ac6a7c944911207e8a9c344763f0003:
> 
>   memory: omap-gpmc: Don't try to save uninitialized GPMC context (2015-08-12 01:43:49 -0700)

Thanks, merged.


-Olof
