From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH] ARM: Blacklist GCC 4.8.0 to GCC 4.8.2 - PR58854
Date: Thu, 16 Oct 2014 10:58:06 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1410161052520.9094@knanqh.ubzr>
References: <E1XeWYh-0004Mw-FC@rmk-PC.arm.linux.org.uk>
 <543EF2B6.1050009@hurleysoftware.com>
 <20141016001801.GQ12379@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20141016001801.GQ12379@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Otavio Salvador <otavio@ossystems.com.br>, Nathan Lynch <Nathan_Lynch@mentor.com>, David Laight <David.Laight@ACULAB.COM>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 16 Oct 2014, Russell King - ARM Linux wrote:

> So, let me put this another way: a compiler with this bug is _completely_
> unsuitable for use for compiling programs for use under the Linux
> kernel _as well_ as the Linux kernel itself.
> 
> The difference is that the Linaro compilers come with an expectation
> that they are usable on ARM... whereas stock versions cover a lot more
> and so the ARM arch is probably very small number of their users.
> 
> Hence why I recommend that Linaro takes down their buggy compiler.
> Their 4.8.3 version should not be used *anywhere*, just the same as
> the stock 4.8 to 4.8.2 inclusive should also not be used anywhere on
> ARM either.

Here's the answer from the toolchain team:

On Thu, 16 Oct 2014, Yvan Roux <yvan.roux@linaro.org> wrote:

| Hi Nicolas,
|
| thanks for bringing this to our knowledge.
|
| The fix for PR58854 was included in our releases since the GCC
| 4.8-2013.12 which is based on a 4.8.3 prerelease version (at svn
| revision 205577).  As we are doing monthly releases based on a
| revision of the related FSF branch, using GCC_VERSION (__GNUC__,
| __GNUC_MINOR,__GNUC_PATCHLEVEL) is not accurate enough to identify the
| release version (all our releases between November 2013 and May 2014
| will be 4.8.3) the __VERSION__ predefined macro is a bit more accurate
| here ("4.8.3 20131202 (prerelease)") but not completely satisfactory.
|
| I completely agree that we should at least mention in our impacted
| releases download pages that this bug is present.


Nicolas
