From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/8] Regulator: Adding header file for TPS65023
Date: Fri, 7 Aug 2009 16:55:58 +0100
Message-ID: <20090807155558.GJ639@sirena.org.uk>
References: <1249658736-10811-1-git-send-email-anuj.aggarwal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753762AbZHGPz7@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1249658736-10811-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anuj Aggarwal <anuj.aggarwal@ti.com>
Cc: lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 07, 2009 at 08:55:36PM +0530, Anuj Aggarwal wrote:

This is OK but since you'll need to resubmit anyway it might be nice to
consider moving the register & bitfield definitions into the driver file
since they can't be used by any other code.

> +/* DCDC's */

Extra ' here :)
