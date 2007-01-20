From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: SPI related oops
Date: Sat, 20 Jan 2007 14:09:09 +0100
Message-ID: <85ps99alqi.fsf@orfeo.duckcorp.org>
References: <85mz4gdsqt.fsf@orfeo.duckcorp.org>
	<200701191543.05564.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <200701191543.05564.david-b@pacbell.net> (David Brownell's
	message of "Fri, 19 Jan 2007 15:43:04 -0800")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

David Brownell <david-b@pacbell.net> writes:

> On Thursday 18 January 2007 11:44 am, Arnaud Patard wrote:
>> Hi,
>> 
>> Since some time ago I was seeing a reboot as long as my n770 was
>> booting recent kernels from the omap git. Now, I found out that the
>> crash is due to a oops as soon as udev plays with the uevent file of the
>> spi master. 
>> After some debugging, I found that the following commit is the culprit : 
>> http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=commit;h=3bd0f6943520e459659d10f3282285e43d3990f1
>> 
>> Reverting it allows my kernel to boot but I think it's not a real
>> fix. Has someone seen a similar issue and has a fix for it ?
>
> Yeah, that patch shouldn't have been merged.  Someone posted a
> working patch on LKML not long ago, but I'd prefer a simpler fix.

Ok. Happy to see that it's not a local issue.

>
>  
>> [ Also, I'm wondering why the spi_busnum_to_master() function exists
>> because grepping the current omap git tree gives 0 user... ]
>
> It exists to support non-integrated SPI adapters.  Consider a PCI
> plug-in card with a couple SPI interfaces, or one accessed through
> a USB link to a microcontroller.

Thanks for the explanation

Arnaud
