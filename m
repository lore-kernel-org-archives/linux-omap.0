From: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
Subject: Re: Suspending with keypad bug (RFC)
Date: Sun, 06 Aug 2006 22:25:51 +0300
Message-ID: <44D6423F.3070001@solidboot.com>
References: <fb249edb0608041633y58eef1b8we6f00cccf69c99a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fb249edb0608041633y58eef1b8we6f00cccf69c99a0@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: balrogg@gmail.com
Cc: Linux-OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

andrzej zaborowski wrote:

> I came up with a different fix, in the keypad driver but it's a bit
> more intrusive. With this the device sleeps peacefully until another
> key-press is detected. What should be the correct behavior?
> I'm attaching both changes.

This approach is better; the generic PM code should not have to care 
that much about different wakeup sources.

I'm not exactly sure in which state the system is when the suspend 
function is called.  Can there still be timer activity, for example? 
Nevertheless, you're safer doing a spin_lock_irqsave() in the suspend 
function first, and releasing the lock only after setting the suspended 
variable and re-enabling the interrupt.

You should also check whether you're actually running on OMAP1 before 
you write to the register.

In the IRQ handler, you should also do a spin_lock_irqsave() before 
accessing the suspended variable.

Cheers,
Juha
