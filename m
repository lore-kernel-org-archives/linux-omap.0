From: Tero Kristo <t-kristo@ti.com>
Subject: Re: n900 in next-20170901
Date: Tue, 14 Nov 2017 22:01:33 +0200
Message-ID: <e07fae95-2125-2d50-7295-ad58f9710801@ti.com>
References: <20171109003639.GB23982@js1304-P5Q-DELUXE>
 <20171109035031.GA24383@js1304-P5Q-DELUXE>
 <20171109150854.GC28152@atomide.com>
 <20171110001315.GA29669@js1304-P5Q-DELUXE>
 <20171110032610.GJ28152@atomide.com>
 <20171110063727.GA32073@js1304-P5Q-DELUXE>
 <20171110153620.GO28152@atomide.com>
 <20171114063724.GA16969@js1304-P5Q-DELUXE>
 <20171114173719.GA28152@atomide.com>
 <5c885f60-bc8c-5f8e-dc81-57eacc57abc8@ti.com>
 <20171114194432.GB28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171114194432.GB28152@atomide.com>
Content-Language: en-US
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ivo.g.dimitrov.75@gmail.com, Andrew Morton <akpm@linux-foundation.org>, khilman@kernel.org, Vlastimil Babka <vbabka@suse.cz>, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, abcloriens@gmail.com, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, Russell King <linux@armlinux.org.uk>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org

On 14/11/17 21:44, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [171114 19:34]:
>> I guess you could just use rx51_secure_dispatcher and ditch the
>> save_secure_ram_context call completely (and most of the other related
>> code)? That one would handle the cache also in a clean manner.
>>
>> Something like:
>>
>> rx51_secure_dispatcher(25, 0, FLAG_START_CRITICAL, 4,
>> __pa(omap3_secure_ram_storage), 0, 1, 1);
> 
> That's different, as rx51_secure_dispatcher does the following:
> 
> - Use arguments + 1 instead of 4, we currently use just 4
> - Disables local_irq and fiq, we are not doing that now
> - Flushes and invalidates cache range, we are not doing that
> - Calls omap_smc3 that only does mov r6, #0xff, and does not
>    do mov r2, #4
> - Missing nops after it's done
> 
> This just based on a quick look I did earlier. So just
> because of the extra work it does we don't want to do it
> even if it worked :)

Hmm ok, I was just thinking that all the extra flushes, irq disables 
etc. might be good to have in place, as a safeguard when entering secure 
mode. You might get glitches in certain conditions otherwise.

The things it is missing might just be clutter.

Anyway, that said, the changes you did look sane, but I might have 
cleaned it up a bit further. :)

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
