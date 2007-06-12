From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix omap1510-generic board compilation.
Date: Tue, 12 Jun 2007 11:32:57 -0700
Message-ID: <20070612183257.GD29514@atomide.com>
References: <fb249edb0706061945n20d12010scf13154d981c0657@mail.gmail.com>
	<20070608103126.GM28556@atomide.com>
	<fb249edb0706100452i479dcfft3ba050dfade880ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <fb249edb0706100452i479dcfft3ba050dfade880ff@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: andrzej zaborowski <balrogg@gmail.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* andrzej zaborowski <balrogg@gmail.com> [070610 04:53]:
> On 08/06/07, Tony Lindgren <tony@atomide.com> wrote:
>> * andrzej zaborowski <balrogg@gmail.com> [070606 19:46]:
>> > Move an #endif so that it doesn't hide the mmc config declaration.
>> > Minor formatting change.
>> >
>> > Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
>>
> [...]
>> This one does not seem to apply, did you forget to send your patch
>> 0006 that this depends on?
>
> Sorry, forgot to update my tree before diffing. Attached is a version
> that applies. Sorry for the noise.

:)

> 0006 was the collective defconfig update which doesn't seem to have
> made it to everyone's mailboxes because it was 200+ KB. Will resend
> the update separated per board.

Thanks, pushing today.

Tony
