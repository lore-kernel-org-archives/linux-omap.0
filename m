From: Kevin Hilman <khilman@mvista.com>
Subject: Re: WARNING at kernel/irq/resend.c:70 check_irq_resend() on OSK
Date: Fri, 10 Aug 2007 15:38:06 -0700
Message-ID: <46BCE8CE.80200@mvista.com>
References: <46BC9999.30805@googlemail.com> <46BCDA7D.9060004@mvista.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429019C5035@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429019C5035@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Woodruff, Richard wrote:

> Were you seeing it consistently on today's GIT after compile fix ups?

Yes.

> I'm not.  But, seems like I still have some hacks in the resend code.  Back on 19 I had some tick issues and I created a patch which I applied to my local git.  I've not bothered to remove those yet.  Don't know if they are fixing/masking something.  Why don't you shut off Dtick and see if you still have it.

I tried with HRT+NO_HZ and without both, and I see the same backtrace
consistently.

>>> While booting on OSK, I get stuff below. Any idea? Note that kernel goes
>>> on booting and nothing feels broken.
>>>
>> FWIW, I see this on 2430 too.
>>
>> This is from  some temporary debug code added[1] that made it into
>> 2.6.23-rc2, but was recently removed by Linus[2]
> 
> Regards,
> Richard W.
