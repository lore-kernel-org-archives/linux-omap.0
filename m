From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v2 04/22] Documentation: PCI: Guide to use pci endpoint
 configfs
Date: Fri, 17 Feb 2017 09:15:06 -0800
Message-ID: <20170217171506.GB15276@infradead.org>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-5-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1487325042-28227-5-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

I'm commenting on the configfs layout here instead of the patch with the
code as the issues are easier to explain that way.  I think the layout
is a bit confusing and could be cleaner by making use of pre-created
entries and symlinks.  Here is my suggestion:

/sys/kernel/config/pci_ep/functions/		
    .. test/					# a directory for each function driver
       ... user-specified-name1/
       ... user-specified-name2
    .. nvme/
       ... user-specified-name42/		

Each directory under /sys/kernel/config/pci_ep/functions/ is owned
by a function drivers.  Under that function driver's directory you
can create a directory for each instance of a function driver.  The
configfs layout is controlled by the function driver.  E.g. your current
EPF fields would move into the test function driver, while the nvme
function would expose totally different fields.


/sys/kernel/config/pci_ep/controllers/
	... dwc-0/
	    ... function
	... dwc-1/
	    ... function
	... vhost-0/
	    ... function

	Here you have a directory for each controller that can be bound
	to a function.  The directories are pre-created for each
	controller port that is EP capable.
	Function is a symlink to the function instance above.
	Additional parameters might also be present depending on the
	EPC driver.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
