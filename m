From: "Valentin, Eduardo" <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/4] staging: omap-thermal: Correct checkpatch.pl warnings
Date: Wed, 12 Sep 2012 12:19:00 +0300
Message-ID: <CAGF5oy8kyMOO+0kxHO054LKxEh5jkUQGUuUM4OF0ncQV4x8uxQ@mail.gmail.com>
References: <1347379615-6881-1-git-send-email-eduardo.valentin@ti.com>
 <1347379615-6881-2-git-send-email-eduardo.valentin@ti.com>
 <20120912081127.GB19396@mwanda> <20120912082639.GI19410@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20120912082639.GI19410@mwanda>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, b-cousson@ti.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hello Dan,

On Wed, Sep 12, 2012 at 11:26 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> On Wed, Sep 12, 2012 at 11:11:27AM +0300, Dan Carpenter wrote:
>> On Tue, Sep 11, 2012 at 07:06:52PM +0300, Eduardo Valentin wrote:
>> > From: J Keerthy <j-keerthy@ti.com>
>> >
>> > Removes checkpatch warnings on omap-bandgap.c.
>> >
>>
>> Which checkpatch.pl warnings?
>>
>> > +                           omap_bandgap_writel(bg_ptr,
>> > +                                   rval->tshut_threshold,
>> > +                                              tsr->tshut_threshold);
>>
>> That's just whacky.
>>
>> Personally, I've never cared much about long lines, so I'd prefer
>> to leave these as is until someone can break the functions up and
>> remove them in a proper way instead of just shifting everything
>> randomly to the left.
>>
>
> Sorry, that was my default response without looking at the code.
>
> This is already broken up into small functions pretty nicely.  You
> might want to consider using shorter names.  For example
> omap_bandgap_writel() could be changed to "obg_writel()" and "bg_ptr"
> could be changed to just "bg" because it's obviously a pointer.

Yeah, that's one option. Of course the deal is to find the proper
balance between cryptic symbol names and code mangled / shifted to the
left.

>
> regards,
> dan carpenter



-- 

Eduardo Valentin
