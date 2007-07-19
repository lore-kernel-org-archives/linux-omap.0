From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: 2430 FB driver issues
Date: Wed, 18 Jul 2007 21:21:49 -0500
Message-ID: <469ECABD.4020106@gmail.com>
References: <782515bb0707031706l32231cbbv34a67572068b835f@mail.gmail.com>	<468E9632.1080205@mvista.com>	<Pine.LNX.4.64.0707081657410.5848@utopia.booyaka.com>
	<200707091204.21320.hyau@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200707091204.21320.hyau@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hunyue Yau <hyau@mvista.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

All,
Apologies on a late response..
Hunyue Yau stated on 7/9/2007 2:04 PM:
> Paul,
>
> It should have been working when it went it. The commit entry 
> adding it should be:
>
> commit 4ed427693dd7e0d4fd00a493988cefaa17accebc
> Author: Hunyue Yau <hyau@mvista.com>
>
>   
to keep things simple, here is the set of facts that i gathered:
a) With Hunyue patch(4ed427693dd7e0d4fd00a493988cefaa17accebc),
Framebuffer is enabled, BUT LCD backlight does not come on, nor does
anything come to the display. Intrestingly, as Hunyue mentioned, NO errors.
b) Patch from Paul (5c6cd5d71bdb1a8536238c7812f1dbd6a68bc542), enables
LCD on 2430SDP with LCD backlight and all.. This is the first patch that
makes 2430SDP LCD work and the error that i started this chain with exists!
c) all intermediate patches between (a) and (b) including the following:
Richard W (bbe8d2b1654809c39be2e9ecc91dd5632006a2cb)
Tony (517928578afaea422975fd8216242fdd067b56a2)
Tony(dd1d9a62f7cd60b544013eb429d6a3137617f0b2)
all retain the same state as I mentioned in (a).

Not much useful information except that my guess is FB LCD is broken on
2430SDP as of date and it is possibly broken from the time it is
enabled.. Since i do see Tony punching in a bunch every weekend, did
Hunyue test with the git latest once Tony finished pushing all patches?
- esp since May 25th is the time when the major clock/prcm  framework
patches from Paul W went into git.
> On Sunday 08 July 2007 16:01, Paul Walmsley wrote:
>   
>> You mentioned earlier that this code formerly worked for you before the 
>> PRCM changes.  Do you have a commit ID or revision from a working version? 
>> if so then perhaps Nishanth or someone else with a 2430 SDP might be able 
>> to git-bisect to find which commit broke it.
>>
>>     
Hmm... I did try this, and i failed badly.. this is a topic of a
seperate mail..

Regards,
Nishanth Menon
