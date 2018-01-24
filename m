From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED] kexec issue with v4.15-rc on N8x0
Date: Thu, 25 Jan 2018 00:18:59 +0200
Message-ID: <20180124221859.i3jafh5cr4ppf2tm@darkstar.musicnaut.iki.fi>
References: <20180111194747.k5qwz66mfntj6v2g@darkstar.musicnaut.iki.fi>
 <20180115181508.GM4821@atomide.com>
 <20180122220654.k6atriweesf2qmw4@darkstar.musicnaut.iki.fi>
 <20180123204544.GM28231@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180123204544.GM28231@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Jan 23, 2018 at 08:45:44PM +0000, Russell King - ARM Linux wrote:
> I'm rather sick of these image placement issues, there seems to be no
> solution here that works for everyone, no matter how hard I try with
> my knowledge of how the ARM kernel decompresses and places itself.

Passing "--image-size" manually to kexec with some big enough value
should work for everyone...

At least this way I finally get a working boot with unpatched 4.15-rc9
and kexec-tools 2.0.16.

A.
