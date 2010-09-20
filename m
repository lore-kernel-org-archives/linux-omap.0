From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] opp: introduce library for device-specific OPPs
Date: Mon, 20 Sep 2010 08:26:44 -0700
Message-ID: <878w2w4erv.fsf@deeprootsystems.com>
References: <201009180107.51664.rjw@sisk.pl> <4C93FAD1.80108@ti.com>
	<201009182041.41675.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201009182041.41675.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Sat, 18 Sep 2010 20:41:41 +0200")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, lkml <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

[...]

>> >> In terms of the lifetime rules on the nodes in the list:
>> >> The list is expected to be maintained once created, entries are expected 
>> >> to be added optimally and not expected to be destroyed, the choice of 
>> >> list implementation was for reducing the complexity of the code itself 
>> >> and not yet meant as a mechanism to dynamically add and delete nodes on 
>> >> the fly.. Essentially, it was intended for the SOC framework to ensure 
>> >> it plugs in the OPP entries optimally and not create a humongous list of 
>> >> all possible OPPs for all families of the vendor SOCs - even though it 
>> >> is possible to use the OPP layer so - it just wont be smart to do so 
>> >> considering list scan latencies on hot paths such as cpufreq transitions 
>> >> or idle transitions.
>> > 
>> > If the list nodes are not supposed to be added and removed dynamically,
>> > it probably would make sense to create data structures containing
>> > the "available" OPPs only, once they are known, and simply free the object
>> > representing the other ones.
>> I covered the usage in my reply here: 
>> http://marc.info/?l=linux-arm-kernel&m=128476570300466&w=2
>> but to repeat, the list is dynamic during initialization but remains 
>> static after initialization based on SOC framework implementation - this 
>> is best implemented with a list (we had started with an original array 
>> implementation which evolved to the current list implementation 
>> http://marc.info/?l=linux-omap&m=125912217718770&w=2)
>
> Well, my point is, since the _final_ set of OPPs doesn't really
> change, there's no need to use a list for storing it in principle.
>
> Your current algorithm seems to be:
> (1) Create a list of all _possible_ OPPs.
> (2) Mark the ones that can actually be used on the given hardware as
>     "available".
> (3) Whenever we need to find an OPP to use, browse the entire list.
> This isn't optimal, because the OPPs that are not marked as "available" in (2)
> will never be used, although they _will_ be inspected while browsing the list.

A little clarificaion about "will never be used" below...

> So, I think a better algorithm would be:
> (1) Create a list of all possible OPPs.
> (2) Drop the nonavailable OPPs from the list.
> (3) Whenever we need to find an OPP to use, browse the entire list.
>
> But then, it may be better to simply move the list we get in (2) into an
> array, because the browsing is going to require fewer memory accesses in
> that case (also, an array would use less memory than the list).  So, perhaps,
> it's better to change the algorithm even further:
> (1) Create a list of all possible OPPs.
> (2) Drop the nonavailable OPPs from the list.
> (3) Move the list we got in (2) into a sorted array.
> (4) Whenever we need to find an OPP to use, browse the array
>      (perhaps using binary search).

Just a little clarification on "available."  The intended use of this flag
was not just a one-time "available on hardware X."  It was also intended
to be able to add/remove availbale OPPs dynamically at run-time.

More specifically, it's intended for use to *temporarily* remove an OPP
from being selected.  The production usage of this would primarily for
thermal considerations (e.g. don't use OPPx until the temperature drops)

However, for PM development & debug, we also use this to temporarily
take a class of OPPs out of the running for test/debug purposes
(e.g. driver X runs great at OPPx and OPPy, but not OPPz.)  So the
ability to temporarily be selective about OPPs at runtime for
debug/development is extremely useful.

So, to summarize, "most of the time", all the OPPs that were added (via
opp_add()) will be "available".  Ones that are !availble will likely
only be so temporarily, so I'm not sure that the overhead of keeping a
separate structure for the available and !available OPPs is worth it.
Especially, since OPP changes are relatively infrequent.

Kevin
