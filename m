From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: Re: Unable to find JFFS2 partition ... but I know it's there !!
Date: Thu, 20 Jun 2013 12:09:05 +0100
Message-ID: <51C2E2D1.3040707@newflow.co.uk>
References: <51C2CBF1.5060900@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51C2CBF1.5060900@newflow.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 20/06/13 10:31, Mark Jackson wrote:
> I'm struggling to debug an issue where the kernel is unable to
> find a JFFS2 partition held in NOR flash (on CS0)

Fixed ... I finally worked out I needed to add:-

CONFIG_MTD_BLOCK
CONFIG_MTD_BLOCK2MTD

Sorry for the noise.

Mark J.
