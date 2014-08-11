From: Darryl <ddegraff@licor.com>
Subject: Re: OMAP3/AM3517 EHCI USB Issue
Date: Mon, 11 Aug 2014 11:22:03 -0500
Message-ID: <53E8EDAB.7000807@licor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

A number of folks had discussed this issue.  I have a similar problem on 
3.13.2. Wondering if there is any progress.

One issue that we noticed, in reviewing the 2.6.32 kernel + patches from 
LogicPD, was that the phy was not taken out of reset, but even this did 
push us forward.


Please mail me directly as I am not subscribed.
