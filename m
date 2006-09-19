From: "andrzej zaborowski" <balrog@zabor.org>
Subject: Re: irda-utils
Date: Tue, 19 Sep 2006 20:49:17 +0200
Message-ID: <fb249edb0609191149o9f434e6if38f9de1e72b820b@mail.gmail.com>
References: <20060918123427.41910.qmail@web30613.mail.mud.yahoo.com>
	<450F4276.60504@gmail.com>
Reply-To: balrogg@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <450F4276.60504@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Nishanth Menon <menon.nishanth@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 19/09/06, Nishanth Menon <menon.nishanth@gmail.com> wrote:
> Zgembo Adislic stated on 9/18/2006 7:34 AM:
> > Hi,
> >
> > Does anyone have irda-utils cross-compiled for omap5910 (ARM9)?  I am using 2.6.8.1 kernel.
> Last I heard was that folks used to compile off the filesystem itself.
> irda-utils seem not to like cross_compile..mebbe someone in the list has
> had better luck?

I cross-compiled a static irattach some time ago and I don't remember
any problems with it, although the other executables had some
dependencies, fortunately I didn't need anything more than irattach.

Zgembo: you can use any ARM build of irda-utils. For example download
the package from Debian or Familiar repositories.
-- 
balrog 2oo6
