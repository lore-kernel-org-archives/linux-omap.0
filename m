From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: omap4: gpio: fix setting IRQWAKEN bits
Date: Mon, 06 Jun 2011 15:32:29 -0700
Message-ID: <87r576wpz6.fsf@ti.com>
References: <1307214239-16316-1-git-send-email-ccross@android.com>
	<BANLkTingmUNvZO_szivRkmn7LRO4L5A+5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTingmUNvZO_szivRkmn7LRO4L5A+5Q@mail.gmail.com> (Colin
	Cross's message of "Sat, 4 Jun 2011 19:37:54 -0700")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Todd Poynor <toddpoynor@google.com>
Cc: Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, lkml <linux-kernel@vger.kernel.org>, Colin Cross <ccross@android.com>, l-o <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Colin Cross <ccross@android.com> writes:

> On Sat, Jun 4, 2011 at 12:03 PM, Colin Cross <ccross@android.com> wrote:
>> Setting the IRQWAKEN bit was overwriting previous IRQWAKEN bits,
>> causing only the last bit set to take effect, resulting in lost
>> wakeups when the GPIO controller is in idle.
>>
>> Replace direct writes to IRQWAKEN with writes to SETWKUENA and
>> CLEARWKUEN.
>>
>> Signed-off-by: Colin Cross <ccross@android.com>

[...]

>
> Todd pointed out that the OMAP4 TRM says not to use SETWKUENA and
> CLEARWKUENA.  

In my GPIO cleanups, I was wondering why the set/clear registers were
not used here. Todd, can you give the TRM version & reference for this?
I didn't find anything after a quick scan/search.

Thanks,

Kevin
