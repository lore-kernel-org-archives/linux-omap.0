From: Tony Lindgren <tony@atomide.com>
Subject: Re: Bunch of serial warnings in next at least with omap-serial
Date: Tue, 3 May 2016 14:58:21 -0700
Message-ID: <20160503215821.GR5995@atomide.com>
References: <20160503203930.GQ5995@atomide.com>
 <572911BF.8000803@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <572911BF.8000803@hurleysoftware.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Peter Hurley <peter@hurleysoftware.com> [160503 14:03]:
> Hi Tony,
> 
> On 05/03/2016 01:39 PM, Tony Lindgren wrote:
> > Hi Peter,
> > 
> > Looks like probably commit 4047b37122d1 ("serial: core: Prevent unsafe
> > uart port access, part 1") in Linux next causes tons of warnings with at
> > least omap-serial. It does not revert cleanly I have not tested with that
> > reverted. Any ideas? Dmesg output of the errors below.
> 
> Thanks for the report.
> Patch below should fix that.

Yes thanks that fixes it:

Tested-by: Tony Lindgren <tony@atomide.com>
