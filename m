From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] pinctrl: Add generic pinctrl-simple driver that supports
 omap2+ padconf
Date: Wed, 16 May 2012 09:53:50 -0600
Message-ID: <4FB3CD8E.3030308@wwwdotorg.org>
References: <20120503065131.GA3738@game.jcrosoft.org> <20120503152708.GC5140@atomide.com> <4FA30805.5050804@wwwdotorg.org> <20120504044305.GD7788@game.jcrosoft.org> <20120504150342.GI5140@atomide.com> <20120504153251.GE7788@game.jcrosoft.org> <20120504163420.GA5613@atomide.com> <4FA42631.6060304@wwwdotorg.org> <20120504220809.GW5613@atomide.com> <4FAAD141.3090306@wwwdotorg.org> <20120509204925.GV5088@atomide.com> <4FABF553.20601@wwwdotorg.org> <CACRpkdbqjofEi-5J+GTMOXFK1VvbXqa6At1fKXCge+5_y6aaRA@mail.gmail.com> <4FB1513A.4070002@wwwdotorg.org> <CACRpkdZCJXy4EMCa0x8pOLUOz=646_housV8qyqMh9AgfwxxUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZCJXy4EMCa0x8pOLUOz=646_housV8qyqMh9AgfwxxUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 05/16/2012 01:14 AM, Linus Walleij wrote:
> On Mon, May 14, 2012 at 8:38 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 05/12/2012 05:49 PM, Linus Walleij wrote:
...
>>> Maybe "-simple" isn't such a good name for this thing. Noone thinks
>>> any kind of pin control is simple in any sense of the word anyway :-D
>>>
>>> Tony, would pinctrl-dt-only.c be a better name perhaps?
>>
>> That might be OK for the filename, but it doesn't seem like a useful
>> change for the DT compatible value.
> 
> Oh I didn't think of these. Hm from a generic world running Windows
> Mobile etc I take it that this is seen as simple mappings then?

I can't think of anything that's much better than pinctrl-simple.
Perhaps pinctrl-generic; at least that doesn't imply it's simple if we
keep adding features:-)
