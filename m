From: Tejun Heo <tj@kernel.org>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
Date: Mon, 6 Aug 2018 10:24:24 -0700
Message-ID: <20180806172424.GC410235@devbig004.ftw2.facebook.com>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
 <20180620102904.GC112168@atomide.com>
 <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
 <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
 <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
 <CAFY_6qq3=+hMLKr0VtCe-witPtV2LTeBSQb3pwqdzysbyiYtMQ@mail.gmail.com>
 <5206d66d-56d0-2edc-8dd0-00eedbaac3db@ti.com>
 <20180702093243.GO112168@atomide.com>
 <CAFY_6qo83Ui6_xRkuTYZUduUJSK2dLKhzd+B_nQ-XW5ciDH-7A@mail.gmail.com>
 <20180806093015.6099ef5c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180806093015.6099ef5c@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Samuel Morris <samorris@lexmark.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, linux-omap@vger.kernel.org, Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, ssantosh@kernel.org, Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hello,

On Mon, Aug 06, 2018 at 09:30:15AM +1000, Stephen Rothwell wrote:
> > > So this issue is still happening as of next-20180702. Can you guys
> > > please revert the commit above while working on a better solution?  
> > 
> > That's fine with me. I'm not very familiar with the process here, does
> > this require anything on my end? And would that require the
> > accompanying patch to be reverted: "ata: ahci: rpm_put port on
> > port_stop to match rpm_get in port_start"? There shouldn't be any
> > problem leaving that one in, but I just want to know before submitting
> > my next patch set.
> 
> I am still reverting that commit from linux-next myself.  Has this
> issue been fixed some other way, or is it still ongoing?

Hasn't been resolved yet.  Reverting from libata/for-4.19.

Thanks.

-- 
tejun
