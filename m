From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 2/6] ARM: AM43xx: Add the PRM IRQ register offsets
Date: Thu, 16 Jul 2015 02:33:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507160208400.32764@utopia.booyaka.com>
References: <1436334148-9309-1-git-send-email-j-keerthy@ti.com> <1436334148-9309-3-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436334148-9309-3-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, galak@codeaurora.org, pawel.moll@arm.com
List-Id: linux-omap@vger.kernel.org

On Wed, 8 Jul 2015, Keerthy wrote:

> Add the PRM IRQ register offsets.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Please add more detail to your commit messages so they conform to 
Documentation/SubmittingPatches:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches#n109

For example, this commit message should read something like:

---

ARM: AM43xx: Add the PRM IRQ register offsets

Add the PRM IRQ register offsets.  This is needed to support PRM I/O 
wakeup on AM43xx.

--

Basically, your patches need to provide context as to _why_ the change is 
needed. 

I've fixed the message for this patch, and queued it for v4.3, but 
please take care with this issue in the future.


- Paul
