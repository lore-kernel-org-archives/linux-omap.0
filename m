From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 00/50] staging: omap-thermal: several code refactoring
Date: Mon, 18 Mar 2013 10:44:59 -0400
Message-ID: <5147286B.9090705@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com>
 <20130316090540.GQ9138@mwanda> <5144698B.9080703@ti.com>
 <20130316161641.GA2630@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20130316161641.GA2630@kroah.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Greg, Dan,

On 16-03-2013 12:16, Greg KH wrote:
> On Sat, Mar 16, 2013 at 08:46:03AM -0400, Eduardo Valentin wrote:
>> Hello Dan,
>>
>> On 16-03-2013 05:05, Dan Carpenter wrote:
>>> I've reviewed this set.
>>>
>>> I hate to make people redo whole patchset sets, and I hate
>>> re-reviewing code.  Obviously, I don't really like the bunny hop
>>> patches and I'm trying to discourage that going forward.  ;P  But
>>> I wouldn't say it's a "Redo the whole thing" kind of problem.
>>>
>>> Could just resend patch 33 and 47?  You should probably be able to
>>> redo those without changing the rest.
>>
>> I could of course change them if the comment is better clarified. As
>> I mentioned as reply to one of your comments, those changes are
>> following what is suggested in CodingStyle file.
>>
>> I can of course send a diff on top of 33, to fix the introduce bug.
>>
>> For 47, I'm not sure the comment is fully applicable.
>
> As I've taken all of these already (sorry Dan, I was fast and I didn't
> review them as well as you did), you will have to just send incremental
> patches on top of the whole series in order for me to be able to apply
> them.

No issues here, I am going to send soon incremental patches, copying 
Dan, to fix the above mentioned issues on 33 and 47.

>
> thanks,
>
> greg k-h
>
>
