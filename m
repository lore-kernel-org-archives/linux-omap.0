From: Tony Lindgren <tony@atomide.com>
Subject: Re: Move linux-omap list over to vger?
Date: Fri, 16 Nov 2007 09:40:08 -0800
Message-ID: <20071116174008.GB32675@atomide.com>
References: <20071115021555.GI6005@atomide.com>
	<7EAD1AEEA7621C45899FE99123E124A001393F5D@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A001393F5D@dbde01.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Syed Mohammed, Khasim <khasim@ti.com> [071116 04:35]:
> Hi Tony,
> 
> We at TI support this move, personally I feel this will bring in lot of
> technical value add / contributions to OMAP software.

OK sounds like everybody thinks we'll benefit from this move.

> However, before moving there were few concerns that we would like to
> discuss upon:
> 
> 1. How to handle the mail archives that we maintain today? 
>  - Should we copy them to major domo? 
>  - Maintain them on current servers?
>  - How will a new subscriber refer to an old discussion captured on
> archive?

I can ask if Dave Miller would be willing to import "old" archives,
but that may not work as they are not vger archives. In any case
we should keep the "old" archives at linux.omap.com, and I can
also mirror the .gz file on kernel.org just in case.

Then on linux.omap.com we can have links to "old" archives and "new"
archives.

So in general, I'd assume we'll be referring to linux.omap.com archives
for the "old" discussions.

> 2. How to handle the "who" query (to get the subscribers list) from
> majordomo? 
>  - Disable "who" query for all (including subscribed members).
>  - Enable "who" query for all - Not recommended. 
>  - Send a mail request to the maintainer "to send the subscriber's list"
> later maintainer can check the genuineness of the request and provide
> the list.

I'd assume "who" is disabled by default on vger because of spammers, and
the subscriber lists are only available to the maintainers.

I'm thinking we'll just ask people to resubscribe to the new list rather
than import the old list.

> 3. By when do we want to make this move? 
>  - Can we wait for couple of weeks? 
>  - We can think of any other issues that we might have to encounter for
> OMAP?

How about let's plan on starting to use linux-omap@vger.kernel.org list
full time on Dec 1st?

We can set it up immediately and then will have few weeks to move over.

> Thank you all for the support in building this strong community for
> OMAP.

Yeah it's nice to see that we have a pretty decent omap development
community now :)

Tony
