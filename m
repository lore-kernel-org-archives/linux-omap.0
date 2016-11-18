From: Olof Johansson <olof@lixom.net>
Subject: Re: [GIT PULL] add #pinctrl-cells for v4.10
Date: Fri, 18 Nov 2016 09:56:29 -0800
Message-ID: <20161118175629.GC8882@localhost>
References: <582a5813.1bc0620a.e65a9.b2cbSMTPIN_ADDED_BROKEN@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <582a5813.1bc0620a.e65a9.b2cbSMTPIN_ADDED_BROKEN@mx.google.com>
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

Hi,

On Mon, Nov 14, 2016 at 04:34:19PM -0800, Tony Lindgren wrote:
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/pinctrl-cells-signed
> 
> for you to fetch changes up to be76fd3197df608e1b010bf5ab90377205f54344:
> 
>   ARM: dts: Add #pinctrl-cells for pinctrl-single instances (2016-11-07 08:27:49 -0700)
> 
> ----------------------------------------------------------------
> Add #pinctrl-cells for pinctrl-single using dts files. This allows
> us to use generic parser later on. Note that the driver supports
> handling the legacy binding also with no #pinctrl-cells so these
> changes can be queued separately from the driver changes.

You forgot to make one commit per file to maximize your patch contribution
count! :-)

Merged, but note that we normally keep arm64 and arm DT updates
separate. I'm gambling on not seeing any conflicts on the hi6220 dtsi
this time around though, and took it in as-is.


-Olof
