From: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: 2.6.16-omap2 tagged & patches available
Date: Tue, 04 Apr 2006 13:57:27 -0700
Message-ID: <4432DDB7.7080204@am.sony.com>
References: <20060403204428.GN13009@atomide.com>
	<20060404144930.GD15266@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <20060404144930.GD15266@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [060403 13:46]:
>> Hi all,
>> 
>> Turns out the MMC bug on H2 and H3 was related to the recent clock id
>> usgage :)
>> 
>> I've tagged 2.6.16-omap1 and posted a patch to the usual location:
>> 
>> http://www.muru.com/linux/omap/
> 
> I generated a quick 2.6.16-omap2 with the 1510 USB host patch in it.
> 

Sorry, seems to be bad.  Nothing inside...

$ quilt push
Applying osk-support/patch-2.6.16-omap2
patch: **** Only garbage was found in the patch input.
Patch osk-support/patch-2.6.16-omap2 does not apply (enforce with -f)
