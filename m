From: Imre Deak <imre.deak@nokia.com>
Subject: Re: is dynamic tick working?
Date: Sun, 14 May 2006 23:31:46 +0300
Message-ID: <446793B2.6040408@nokia.com>
References: <200605121905.13405.david-b@pacbell.net>
	<200605140919.09540.david-b@pacbell.net>
	<44676F78.1010004@nokia.com>
	<200605141220.01825.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200605141220.01825.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: ext David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

ext David Brownell wrote:
> On Sunday 14 May 2006 10:57 am, Imre Deak wrote:
>> 	 The patch is already in the mainline 
>> tree, I've also sent it to Tony after I noticed it's missing from the 
>> OMAP tree. My fault, I should've kept the driver up-to-date in both trees..
> 
> Understandable, given how long it took to get those patches merged
> upstream!  Plus the fact that the version in the OMAP tree was working
> around byteswap bugs on the Microwire SPI driver ... I'm not sure I'd
> have expected Tony to resolve all the merge conflicts right unless he
> were more involved in sorting out those issues.

Yep, to make it work I fixed the thing in the wrong place.

> 
> So let's see.  Other than those recent patches resolving those byteswap
> bugs, and the hwmon features (not all merged upstream yet, sigh), are
> there any reasons left for the OMAP version of that driver to differ from
> the upstream one?

No, they must be in sync now. Since the changes went to mainline and to 
the OMAP tree through different changesets (b/c the above wrong fix et 
al) and now the OMAP version is out of sync, I've sent a patchset to 
Tony to bring it up-to-date.

> 
> My understanding is that thanks (!) mostly to your updates, we're almost
> ready to say OMAP can use the same version of ads7846 that's upstream,
> and that the omap_uwire driver could also go upstream.  And given an OSK
> version of that new routine, that Mistral support could also go upstream.
> Does that sound right?

Yes, the ads7846 and omap_uwire should be ok - and identical with 
upstream after the above patches.

--Imre

> 
> - Dave
