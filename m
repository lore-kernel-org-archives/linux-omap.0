From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Problem with ALSA in 2.6.14-omap2 on OSK
Date: Tue, 13 Dec 2005 16:47:10 +0100
Message-ID: <439EECFE.5000408@de.bosch.com>
References: <520AB2AD990DC04082102F77CA17263801D40597@dlee03.ent.ti.com>	
	<20051123164523.GC7547@atomide.com> <4389F0EB.6000404@de.bosch.com>
	<9268368b0512121114g2e27e7c6s5f41397224ca1eb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <9268368b0512121114g2e27e7c6s5f41397224ca1eb3@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Daniel Petrini <d.pensator@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Daniel Petrini wrote:
> Hi Dirk,
> 
> On 11/27/05, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> 
>>Tony Lindgren wrote:
>>
>>>* Menon, Nishanth <x0nishan@ti.com> [051123 08:37]:
>>>
>>>
>>>>There is further the fix to L/R sync issue as reported by Ajaya Babu in
>>>>a previous mail in this list for the OSS - it might hit the ALSA too if
>>>>the condition is not met properly.
>>>
>>>
>>>To me it sounds like Ajaya Babu's fix to stop mcbsp before dma is
>>>enabled probably fixes the remaining problems.
>>>
>>>Does anybody have a tested patch for OSS and Alsa for that?
>>
>>In the attachment a patch for Alsa as described by Ajaya Babu (hopefully
>>correct?). Unfortunately it seems to not fix the issues with repeated
>>audio parts while using Alsa.
> 
> 
> I tested it and it worked fine here, with version omap-2.6.15-rc4
> (without rollbacks in dma.c).

Thanks for testing! Seems strange to me why Yves and I have these
glitches, and you not. As you can see by my L/R patch posted to the
list, I switched back to OSS.

Some notes to my environment. I'm using ~5MB mp3 playing over NFS with
madplay in ramdisk. Yesterday, I had an additional idea, but no time to
test it yet: Do you have PREEMPT (CONFIG_PREEMPT=y) enabled? May be this 
is the difference?

Dirk
