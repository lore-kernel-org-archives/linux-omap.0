From: Robert Abel <rabel@cit-ec.uni-bielefeld.de>
Subject: Re: [PATCH 2/8] ARM OMAP2+ GPMC: add bus children
Date: Tue, 3 Mar 2015 11:43:42 +0100
Message-ID: <CAMdRc4F9bWCC+Edfc7C0bS6-9D-O-C8WKc+txLfOeBt9VP-DUQ@mail.gmail.com>
References: <1424961956-29353-1-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<1424961956-29353-3-git-send-email-rabel@cit-ec.uni-bielefeld.de>
	<54F045F2.7010005@ti.com>
	<CAMdRc4F2EaDxrBAMUQ3NGvBt4sMnYX3FQXZttFzcPZJdKkOMLw@mail.gmail.com>
	<54F58877.2090608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F58877.2090608@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Linux Kernel Maling List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Tue, Mar 3, 2015 at 11:09 AM, Roger Quadros <rogerq@ti.com> wrote:
> If that is the case then I'd rather not check for return value of of_platform_populate().
> Failure in populating GPMC child's children is already out of scope of GPMC driver.

Well, I'd rather leave it in for now. If something *does* break in the
future, the user will at least get a message about it.

Regards,

Robert
