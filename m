From: Aishwarya Pant <aishpant@gmail.com>
Subject: Documentation: OMAPDSS: move sysfs documentation to ABI
Date: Tue, 2 Jan 2018 14:24:36 +0530
Message-ID: <20180102085436.GA32637@mordor.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-doc-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jonathan Corbet <corbet@lwn.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

Hi

In Documentation/arm/OMAP/DSS, there is a description of the DSS and FB sysfs
interfaces which could be moved to Documentation/ABI.

Would such a change be useful? I can see that the sysfs interface is still in
testing.

The ABI documentation format looks like the following:

What:          (the full sysfs path of the attribute)
Date:          (date of creation)
KernelVersion: (kernel version it first showed up in)
Contact:       (primary contact)
Description:   (long description on usage)

I am doing this in an exercise to move sysfs ABI interfaces (which are
documented) to their right place i.e. in Documentation/ABI along with the rest.

Aishwarya
