From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH] ARM: OMAP2: Update N800 defconfig
Date: Mon, 05 Mar 2007 14:10:37 +0100
Message-ID: <85mz2r7s4y.fsf@orfeo.duckcorp.org>
References: <45EA9F87.6090300@googlemail.com>
	<85649hjnnp.fsf@orfeo.duckcorp.org> <45EAB2E7.1000607@googlemail.com>
	<85y7mdgpww.fsf@orfeo.duckcorp.org>
	<20070305114831.GD17801@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20070305114831.GD17801@atomide.com> (Tony Lindgren's message of
	"Mon, 5 Mar 2007 03:48:32 -0800")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

Hi,

> * Arnaud Patard <arnaud.patard@rtp-net.org> [070304 04:27]:
>> Dirk Behme <dirk.behme@googlemail.com> writes:
>> 
>> > Arnaud Patard (Rtp) wrote:
>> >>>Update N800 defconfig, mainly to disable netfilter which
>> >>>doesn't compile:
>> >>  Fixing the build may be a better idea than disabling it.
>> >
>> > Yes, your are right ;) But this is something we can't do here on OMAP
>> > list.
>> 
>> I disagree. This driver afaik can only be found in the omap tree and
>> it's only a matter of taking few minutes to update the driver to follow
>> upstream changes. So, unless the original author of the driver fixes it
>> (which I doubt), it's up to us to fix it.
>
> Thanks, can you please add a Signed-off-by to this thread? I'll add
> your patch to the "Add iptables IDLETIMER target" patch in omap-drivers
> branch. Once it's been tested we should try to send it upstream when the
> next merge window opens.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

(I can send it in a new mail if it makes things easier for you)

>  
>> As I said, I have a patch for it. I'm attaching it to this mail for
>> reference because I'm now thinking that I won't be able to test it on my
>> n770.
>
> Binary firmware issue with compiling wlan driver I suppose? :(

yeah. I managed to build the old cx3110x driver from the garage project
(the only one that has the .lib file) but it's crashing when I try to
use the wifi. I'll see if something can be done on the prism54 side but
I fear it will take ages :(

Arnaud
