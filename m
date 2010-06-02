From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 0/3] kmemleak: Fix false positive with special scan
Date: Wed, 02 Jun 2010 15:12:29 +0100
Message-ID: <1275487949.23442.9.camel@e102109-lin.cambridge.arm.com>
References: <20100602.143458.232754971.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100602.143458.232754971.Hiroshi.DOYU@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, ext-phil.2.carmody@nokia.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-06-02 at 12:34 +0100, Hiroshi DOYU wrote:
> From: ext Catalin Marinas <catalin.marinas@arm.com>
> > Can we not add a new prio tree (or just use the existing one) for
> > pointer aliases? The advantage is that you only have a single function
> > to call, something like kmemleak_add_alias() and you do it at the point
> > the value was converted.
> 
> Actually I considered the above aliasing a little bit but I gave up
> soon.
> 
> I was afraid that this method might consume way more memory since this
> just adds another member for "struct kmemleak_object", but adding a
> single member for all objects. The number of kmemleak_object is
> usually numerous.

We could use a different tree with a "struct kmemleak_alias" structure
which is much smaller. Something like below:

struct kmemleak_alias {
	struct list_head alias_list;
	struct prio_tree_node tree_node;
	struct kmemleak_object *object;
}

And an alias_list member would be added to kmemleak_object as well.

Would the alias tree need to allow overlapping? Like different IOMMU
mappings with the same address (but pointing to different physical
memory).

-- 
Catalin
