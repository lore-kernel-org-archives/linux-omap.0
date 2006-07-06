From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH 1/4] Input: ads7846: detect pen up from IRQ state
Date: Thu, 06 Jul 2006 17:58:31 +0200
Message-ID: <44AD3327.4090404@gmail.com>
References: <20060703182931.GA29921@localdomain> <44AA84CC.5020808@gmail.com>
	<20060705161832.GA32247@localdomain> <44ABEC05.7070204@gmail.com>
	<20060705190507.GA32376@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060705190507.GA32376@localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: imre.deak@solidboot.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

imre.deak@solidboot.com wrote:
>>>>Yesterday, you posted a new patchset "[PATCH 1/1-4] Input: 
>>>>ads7846:". As I understand it, this recent patch set is the 
>>>>clean version of ads7846 and is a replacement for the old 
>>>>workaround now pushed by Tony? Or is it an add on?
>>>
>>>The first patch of the set includes that fix. Now that it's pushed I'm
>>>posting an updated version of that first patch. The rest should apply ok.
>>
>>Just applied patch 1-4 to recent git and tried on OSK and 
>>get crash below at module load.
> 
> Just a wild guess, but did you update the kernel as well? The platform
> data struct changed..

Uh, sometimes it can be so easy ;)

Many thanks for the hint

Dirk

P.S.: Works on OSK. I put this patchset on my pending 
patches list.
