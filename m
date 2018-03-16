From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 0/2] net: phy: relax error checking when creating sysfs
 link netdev->phydev
Date: Fri, 16 Mar 2018 22:14:59 +0100
Message-ID: <20180316211459.GC8735@lunn.ch>
References: <20180314222624.12744-1-grygorii.strashko@ti.com>
 <20180316172234.GA4212@lunn.ch>
 <72ff074d-b19d-6ae5-59c9-4aacaa8070fd@gmail.com>
 <e28f0101-cf3e-58f0-82f3-7e45bbe4bf74@ti.com>
 <44DFE938-3FF8-4608-87DD-BC84705EFFF8@gmail.com>
 <f9f7ea0b-4e23-d837-c1b1-73ed7d6fb686@ti.com>
 <20180316195403.GA8735@lunn.ch>
 <0daaae50-ddb9-8a94-d4a7-02861f0a6eb7@ti.com>
 <c790757c-0b4f-575b-1f6a-5f870f840e20@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c790757c-0b4f-575b-1f6a-5f870f840e20@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> I agree, let's not have you run into circles, let's just use your
> patches as they are since they fix the problem and are not intrusive in
> any way.

Agreed, this is too complex, for little gain.

	Andrew
