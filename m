From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: 2.6.16-omap2 tagged & patches available
Date: Tue, 04 Apr 2006 14:44:50 -0700
Message-ID: <4432E8D2.104@am.sony.com>
References: <20060404212212.GH15266@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060404212212.GH15266@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Geoff Levand <geoffrey.levand@am.sony.com> [060404 13:57]:
>> Tony Lindgren wrote:
>> >> I've tagged 2.6.16-omap1 and posted a patch to the usual location:
>> >> 
>> >> http://www.muru.com/linux/omap/
>> > 
>> > I generated a quick 2.6.16-omap2 with the 1510 USB host patch in it.
>> > 
>> 
>> Sorry, seems to be bad.  Nothing inside...
>> 
>> $ quilt push
>> Applying osk-support/patch-2.6.16-omap2
>> patch: **** Only garbage was found in the patch input.
>> Patch osk-support/patch-2.6.16-omap2 does not apply (enforce with -f)
> 
> Oops, that was generated with with cg-patch -s -r, so it was just the
> summary. Should have been cg-patch -r only. Can you try now?

Seems OK.  I could boot osk 5912.

-Geoff
